#!/bin/bash
# backup_setup.sh – Backup your environment into a Git repository

set -e

# Define the repository folder and remote repo URL
REPO_DIR="$HOME/lib/my_setup"
REMOTE_URL="git@github.com:nbatada/my_setup.git"

echo "Creating repository directory at $REPO_DIR..."
mkdir -p "$REPO_DIR"

########################################
# 1. Backup Homebrew packages to Brewfile
########################################
echo "Backing up Homebrew packages..."
brew bundle dump --file="$REPO_DIR/Brewfile" --describe --force

########################################
# 2. Backup pip packages
########################################
if command -v pip3 &>/dev/null; then
    echo "Backing up Python packages to pip_requirements.txt..."
    pip3 freeze > "$REPO_DIR/pip_requirements.txt"
else
    echo "pip3 not found, skipping pip backup."
fi

########################################
# 3. Backup Conda environment
########################################
if command -v conda &>/dev/null; then
    echo "Backing up Conda environment to environment.yml..."
    conda env export > "$REPO_DIR/environment.yml"
else
    echo "conda not found, skipping Conda environment backup."
fi

########################################
# 4. Backup Dotfiles
########################################
DOTFILES_DIR="$REPO_DIR/dotfiles"
echo "Backing up dotfiles to $DOTFILES_DIR..."
mkdir -p "$DOTFILES_DIR"

for file in .zshrc .bash_profile .bashrc .gitconfig; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$DOTFILES_DIR/"
        echo "Copied $file"
    else
        echo "$file not found, skipping."
    fi
done

########################################
# 5. Initialize the Git repository
########################################
cd "$REPO_DIR"
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
fi

# Add remote if not already added
if ! git remote | grep -q "origin"; then
    echo "Adding remote $REMOTE_URL..."
    git remote add origin "$REMOTE_URL"
fi

echo "Adding backup files to the Git repository..."
git add .
git commit -m "Backup environment setup files" || echo "Nothing new to commit."

echo "Backup complete!"
echo "You can now push the repository with:"
echo "  cd \"$REPO_DIR\" && git push -u origin master"
