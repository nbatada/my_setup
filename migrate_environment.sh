#Backup Homebrew Packages with a Brewfile
brew bundle dump --file=~/Brewfile --describe --force
# Export Python Packages
#pip freeze > ~/pip_requirements.txt
pip3 freeze > ~/pip_requirements.txt

#Export Conda Environments 
# For the current environment:
conda env export > ~/environment.yml 
# on the new mac
# conda env create -f ~/environment.yml

# Export R Packages (if applicable)
installed <- as.data.frame(installed.packages()[,c(1,3:4)])
installed <- installed[is.na(installed$Priority), 1:2, drop=FALSE]
write.csv(installed, file="~/R_installed_packages.csv", row.names=FALSE)

#5. Gather Your Dotfiles (Settings/Configuration)
mkdir ~/dotfiles
cp ~/.zshrc ~/.bash_profile ~/.gitconfig ~/dotfiles/
cd ~/dotfiles
git init
git add .
git commit -m "Initial commit of my dotfiles"
# Then push it to your remote repository.

# On the new machine, simply clone your repository and create symbolic links:
# git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
# ln -sf ~/dotfiles/.zshrc ~/
# ln -sf ~/dotfiles/.bash_profile ~/
# ln -sf ~/dotfiles/.gitconfig ~/



# setup.sh – Rebuild your bioinformatics workstation on your new MacBook

# Exit immediately if a command exits with a non-zero status.
set -e

########################################
# 1. Install Homebrew if not installed
########################################
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

########################################
# 2. Install Homebrew packages from Brewfile
########################################
BREWFILE="$HOME/Brewfile"
if [ -f "$BREWFILE" ]; then
    echo "Found Brewfile at $BREWFILE."
    echo "Installing Homebrew packages using Brewfile..."
    brew bundle --file="$BREWFILE"
else
    echo "WARNING: No Brewfile found at $BREWFILE."
    echo "       Please copy your Brewfile to your home directory if needed."
fi

########################################
# 3. Upgrade pip and install Python packages
########################################
if command -v pip3 &>/dev/null; then
    echo "Upgrading pip..."
    pip3 install --upgrade pip
    PIP_REQ="$HOME/pip_requirements.txt"
    if [ -f "$PIP_REQ" ]; then
        echo "Installing Python packages from $PIP_REQ..."
        pip3 install -r "$PIP_REQ"
    else
        echo "WARNING: No pip requirements file found at $PIP_REQ."
    fi
else
    echo "pip3 not found. Skipping Python package installation."
fi

########################################
# 4. Recreate Conda Environment (if using Conda)
########################################
if command -v conda &>/dev/null; then
    ENV_YML="$HOME/environment.yml"
    if [ -f "$ENV_YML" ]; then
        echo "Creating conda environment from $ENV_YML..."
        conda env create -f "$ENV_YML"
    else
        echo "WARNING: No environment.yml file found at $ENV_YML."
    fi
else
    echo "Conda is not installed. If you need Conda environments, install Conda and try again."
fi

########################################
# 5. (Optional) Install R Packages
########################################
# If you maintain an R packages list (e.g., a CSV file or an R installer script), you can call Rscript here.
# Example: suppose you have an R script (install_r_packages.R) that reads your CSV and installs packages.
# Uncomment the following lines if needed.
#
# if command -v Rscript &>/dev/null; then
#     if [ -f "$HOME/R_installed_packages.csv" ]; then
#         echo "Installing R packages using Rscript..."
#         Rscript "$HOME/install_r_packages.R"
#     else
#         echo "WARNING: No R_installed_packages.csv found in $HOME."
#     fi
# else
#     echo "Rscript not found. Skipping R package installation."
# fi

########################################
# 6. Symlink Dotfiles (Shell Configurations)
########################################
DOTFILES_DIR="$HOME/dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
    echo "Linking dotfiles from $DOTFILES_DIR to your home directory..."
    
    # Symlink .zshrc, .bash_profile, and .gitconfig if they exist in the dotfiles directory.
    for file in .zshrc .bash_profile .gitconfig; do
        if [ -f "$DOTFILES_DIR/$file" ]; then
            ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
            echo "Symlinked $file"
        else
            echo "WARNING: $DOTFILES_DIR/$file not found. Skipping."
        fi
    done
else
    echo "WARNING: Dotfiles directory not found at $DOTFILES_DIR."
    echo "         Please clone your dotfiles repository into $DOTFILES_DIR."
fi

echo "=== Setup complete! ==="
echo "If you updated your shell configuration files (e.g., .zshrc, .bash_profile), please restart your terminal."
