# Stage 1: Build Neovim from source
FROM ubuntu:20.04 AS neovim-source

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for building Neovim
RUN apt-get update && apt-get install -y \
    git \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone and build Neovim from source
RUN git clone https://github.com/neovim/neovim.git /neovim \
    && cd /neovim \
    && git checkout stable \
    && make CMAKE_BUILD_TYPE=Release \
    && make install \
    && cd / \
    && rm -rf /neovim

#Stage 1.1 building eza
FROM ubuntu:20.04 AS eza

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install wget
RUN wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
RUN chmod +x eza
RUN chown root:root eza

# Stage 2: Install base packages
FROM ubuntu:20.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Copy Neovim binary from the first stage
COPY --from=neovim-source /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=neovim-source /usr/local/share/nvim /usr/local/share/nvim
COPY --from=eza /eza /usr/local/bin/eza

# Stage 3: Clone dotfiles and bootstrap
FROM base AS dotfiles-setup

RUN apt update && apt install -y git

# Clone the dotfiles repository as a bare repo
RUN git clone https://github.com/maorsom/thegate.git /opt/thegate
