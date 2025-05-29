#!/bin/bash
# restore_setup.sh – Restore your environment from the backup repository

set -e

# Define the repository directory (where you cloned your backup repo)
REPO_DIR="$HOME/lib/my_setup"

echo "Starting restoration from backup repository at $REPO_DIR"

########################################
# 1. Restore Homebrew packages
########################################
BREWFILE="$REPO_DIR/Brewfile"
if [ -f "$BREWFILE" ]; then
    echo "Restoring Homebrew packages from $BREWFILE..."
    # Install Homebrew if not already installed
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew bundle --file="$BREWFILE"
else
    echo "Brewfile not found at $BREWFILE. Skipping Homebrew restoration."
fi

########################################
# 2. Restore pip packages
########################################
PIP_REQ="$REPO_DIR/pip_requirements.txt"
if [ -f "$PIP_REQ" ]; then
    echo "Restoring Python packages from $PIP_REQ..."
    if command -v pip3 &>/dev/null; then
        pip3 install -r "$PIP_REQ"
    else
        echo "pip3 not found. Skipping Python package restoration."
    fi
else
    echo "pip_requirements.txt not found at $PIP_REQ. Skipping pip restoration."
fi

########################################
# 3. Restore Conda environment
########################################
ENV_YML="$REPO_DIR/environment.yml"
if [ -f "$ENV_YML" ]; then
    echo "Restoring Conda environment from $ENV_YML..."
    if command -v conda &>/dev/null; then
        conda env create -f "$ENV_YML"
    else
        echo "Conda not found. Skipping Conda environment restoration."
    fi
else
    echo "environment.yml not found at $ENV_YML. Skipping Conda restoration."
fi

########################################
# 4. Link Dotfiles
########################################
DOTFILES_DIR="$REPO_DIR/dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
    echo "Linking dotfiles from $DOTFILES_DIR to the home directory..."
    for file in .zshrc .bash_profile .bashrc .gitconfig; do
        if [ -f "$DOTFILES_DIR/$file" ]; then
            ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
            echo "Symlinked $file"
        else
            echo "$file not found in $DOTFILES_DIR, skipping."
        fi
    done
else
    echo "Dotfiles directory not found at $DOTFILES_DIR. Skipping dotfiles linking."
fi

echo "Restoration complete!"
