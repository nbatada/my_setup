#!/bin/bash
# prepare_setup_repo.sh – Prepare a repository with your setup files

# Define the repository folder and remote repo URL (update REMOTE_URL accordingly)
REPO_DIR="$HOME/my_setup"
REMOTE_URL="git@github.com:yourusername/my_setup.git"  # Update this with your actual repo URL

echo "Creating repository folder at $REPO_DIR..."
mkdir -p "$REPO_DIR"

echo "Copying configuration and package files into $REPO_DIR..."
# Copy Homebrew Brewfile if it exists
if [ -f "$HOME/Brewfile" ]; then
    cp "$HOME/Brewfile" "$REPO_DIR/"
else
    echo "WARNING: $HOME/Brewfile not found."
fi

# Copy pip requirements file if it exists
if [ -f "$HOME/pip_requirements.txt" ]; then
    cp "$HOME/pip_requirements.txt" "$REPO_DIR/"
else
    echo "WARNING: $HOME/pip_requirements.txt not found."
fi

# Copy Conda environment file if it exists
if [ -f "$HOME/environment.yml" ]; then
    cp "$HOME/environment.yml" "$REPO_DIR/"
else
    echo "NOTE: $HOME/environment.yml not found. Skipping Conda environment export."
fi

# Copy your dotfiles folder if it exists
if [ -d "$HOME/dotfiles" ]; then
    cp -R "$HOME/dotfiles" "$REPO_DIR/"
else
    echo "WARNING: $HOME/dotfiles not found. Please ensure you have your dotfiles backed up."
fi

# (Optional) If you have any additional setup scripts (for R packages, etc.), copy them here, too.

echo "Initializing Git repository..."
cd "$REPO_DIR"
git init

echo "Adding all files..."
git add .

echo "Committing files..."
git commit -m "Initial commit of environment setup files"

echo "Adding remote repository $REMOTE_URL..."
git remote add origin "$REMOTE_URL"

echo "Push the repository to the remote. Run the following command:"
echo "  git push -u origin master"
