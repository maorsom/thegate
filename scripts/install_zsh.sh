#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source $SCRIPT_DIR/colors.sh

ZSH_PATH=$(command -v zsh)
USER_SHELL=$(getent passwd "$USER" | cut -d: -f7)

echo $ZSH_PATH

# Check if Zsh is installed
if ! command -v zsh &>/dev/null; then
    echo -e "${RED}Zsh is not installed. Installing Zsh...${NC}"
    if [[ "$(uname)" == "Linux" ]]; then
        sudo apt update && sudo apt install -y zsh || sudo yum install -y zsh
    elif [[ "$(uname)" == "Darwin" ]]; then
        brew install zsh
    else
        echo -e "${RED}Unsupported OS. Please install Zsh manually.${NC}"
        exit 1
    fi
fi

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo -e "${GREEN}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo -e "${YELLOW}Oh My Zsh is already installed.${NC}"
fi

# Define the target directory for the plugin
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
PLUGIN_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Clone the plugin repository
if [[ -d "$PLUGIN_DIR" ]]; then
    info "zsh-autosuggestions plugin is already installed at $PLUGIN_DIR"
else
    info "Cloning zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR" && success "zsh-autosuggestions installed successfully!" || error "Failed to clone zsh-autosuggestions."
fi

PLUGIN_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Clone the plugin repository
if [[ -d "$PLUGIN_DIR" ]]; then
    info "zsh-syntax-highlighting plugin is already installed at $PLUGIN_DIR"
else
    info "Cloning zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Set Zsh as the default shell
if [[ "$USER_SHELL" != "$ZSH_PATH" ]]; then
    echo -e "${GREEN}Setting Zsh as the default shell...${NC}"
    chsh -s "$(command -v zsh)"
else
    echo -e "${YELLOW}Zsh is already the default shell.${NC}"
fi
