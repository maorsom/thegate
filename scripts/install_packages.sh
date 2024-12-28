#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source $SCRIPT_DIR/colors.sh

# Print success message
function success() {
    echo -e "${GREEN}$1${NC}"
}

# Print error message and exit

function error() {
    echo -e "${RED}$1${NC}"
    exit 1
}

# Update and install required packages
echo -e "${YELLOW}Updating package lists and installing required packages...${NC}" apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    tmux \
    wget \
    fd-find \
    make \
    cmake \
    g++ \
    fzf &&
    apt-get clean &&
    rm -rf /var/lib/apt/lists/* &&
    success "Packages installed successfully!"

# Install zoxide
echo -e "${YELLOW}Installing zoxide...${NC}"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh &&
    success "zoxide installed successfully!"

# Clone the fzf-git.sh repository
echo -e "${YELLOW}Cloning fzf-git.sh repository...${NC}"
git clone https://github.com/junegunn/fzf-git.sh.git "$HOME/fzf-git.sh" &&
    success "fzf-git.sh repository cloned successfully!"
