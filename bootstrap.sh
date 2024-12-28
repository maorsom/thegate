#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

$SCRIPT_DIR/scripts/install_packages.sh "$SCRIPT_DIR"
$SCRIPT_DIR/scripts/install_zsh.sh "$SCRIPT_DIR"
$SCRIPT_DIR/scripts/set_config_folder.sh "$SCRIPT_DIR"
$SCRIPT_DIR/scripts/create_symlinks.sh "$SCRIPT_DIR"
