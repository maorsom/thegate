#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source $SCRIPT_DIR/colors.sh

BACKUP_DIR="$HOME/dotfiles_backup"
mkdir -p "$BACKUP_DIR"

create_symlink() {
    local source_file="$1"
    local target_file="$2"

    # Check if the source file exists
    if [[ ! -e "$source_file" ]]; then
        echo -e "${RED}Error: Source file does not exist: $source_file${NC}"
        return 1
    fi

    # Check if the target already exists
    if [[ -L "$target_file" ]]; then
        local current_link
        current_link=$(readlink "$target_file")
        if [[ "$current_link" == "$source_file" ]]; then
            echo -e "${YELLOW}Symlink already exists and is correct: $target_file -> $source_file${NC}"
            return 0
        else
            echo -e "${RED}Incorrect symlink detected: $target_file -> $current_link${NC}"
            echo -e "${YELLOW}Backing up incorrect symlink...${NC}"
            mv "$target_file" "$BACKUP_DIR/"
        fi
    elif [[ -e "$target_file" ]]; then
        echo -e "${RED}File or folder already exists at target: $target_file${NC}"
        echo -e "${YELLOW}Backing up existing file/folder...${NC}"
        mv "$target_file" "$BACKUP_DIR/"
    fi

    # Create the symlink
    ln -s "$source_file" "$target_file"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}Symlink created: $target_file -> $source_file${NC}"
        source $target_file
    else
        echo -e "${RED}Failed to create symlink: $target_file${NC}"
        return 1
    fi
}

SOURCE_DIR="$SCRIPT_DIR/../symlinks" # The directory containing the source files

create_symlink "$SOURCE_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$SOURCE_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "${GREEN}Symlinks created.${NC}"
