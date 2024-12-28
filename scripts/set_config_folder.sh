#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

source $SCRIPT_DIR/colors.sh

# Backup directory for conflicts
BACKUP_DIR="$HOME/.config/backup.$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

create_symlink() {
    local source_dir="$1"
    local target_dir="$2"

    # Check if the source exists
    if [[ ! -e "$source_dir" ]]; then
        echo -e "${RED}Error: Source directory or file does not exist: $source_dir${NC}"
        return 1
    fi

    # Handle existing target
    if [[ -e "$target_dir" ]]; then
        if [[ -L "$target_dir" ]]; then
            # Check if the symlink is correct
            local current_link
            current_link=$(readlink "$target_dir")
            if [[ "$current_link" == "$source_dir" ]]; then
                echo -e "${YELLOW}Symlink already exists and is correct: $target_dir -> $source_dir${NC}"
                return 0
            else
                echo -e "${RED}Incorrect symlink detected: $target_dir -> $current_link${NC}"
                echo -e "${YELLOW}Backing up incorrect symlink to: $BACKUP_DIR${NC}"
                mv "$target_dir" "$BACKUP_DIR/"
            fi
        else
            # If it's a file or folder, back it up
            echo -e "${RED}File or folder already exists at target: $target_dir${NC}"
            echo -e "${YELLOW}Backing up existing file/folder to: $BACKUP_DIR${NC}"
            mv "$target_dir" "$BACKUP_DIR/"
        fi
    fi

    # Create the symlink
    ln -s "$source_dir" "$target_dir"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Symlink created: $target_dir -> $source_dir${NC}"
    else
        echo -e "${RED}Failed to create symlink: $target_dir${NC}"
        return 1
    fi
}

NVIM_SOURCE_DIR="$SCRIPT_DIR/../configs/nvim" # Path to your custom Neovim configuration
NVIM_TARGET_DIR="$HOME/.config/nvim"          # Default Neovim configuration folder
create_symlink "$NVIM_SOURCE_DIR" "$NVIM_TARGET_DIR"

echo -e "${GREEN}configs folders configuration setup complete!${NC}"
