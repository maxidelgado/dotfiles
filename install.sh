#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# Get the current user using the whoami command
current_user=$(whoami)

# Find and replace ${USERNAME} in all files within the folder
find "." -type f -exec sed -i "s/\${USERNAME}/$current_user/g" {} +

echo "All instances of \${USERNAME} have been replaced with $current_user"

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  log "Homebrew not found. Installing Homebrew..."

  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Determine Homebrew installation path
  if [[ -d "/opt/homebrew/bin" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  elif [[ -d "/usr/local/bin" ]]; then
    HOMEBREW_PREFIX="/usr/local"
  else
    log "Error: Homebrew installation path not found."
    exit 1
  fi

  # Add Homebrew to the PATH in the current shell session
  eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
else
  log "Homebrew is already installed."
fi

# Ensure Homebrew environment is set
if ! command -v brew &>/dev/null; then
  log "Error: Homebrew was not found after installation. Exiting."
  exit 1
fi

# Update Homebrew
log "Updating Homebrew..."
brew update

# Install formulae from leaves.txt
if [[ -f homebrew/leaves.txt ]]; then
  log "Installing formulae from leaves.txt..."
  xargs brew install < homebrew/leaves.txt
else
  log "leaves.txt not found. Skipping formulae installation."
fi

# Install casks from casks.txt
if [[ -f homebrew/casks.txt ]]; then
  log "Installing casks from casks.txt..."
  xargs brew install --cask < homebrew/casks.txt
else
  log "casks.txt not found. Skipping cask installation."
fi

# Run stow to symlink dotfiles
if command -v stow &>/dev/null; then
  log "Running stow to symlink dotfiles..."
  stow .
else
  log "GNU Stow not found. Installing stow..."
  brew install stow
  stow .
fi

# Copy .zshrc file
if [[ -f zshrc/.zshrc ]]; then
  log "Copying .zshrc to home directory..."
  cp zshrc/.zshrc ~/.zshrc
else
  log ".zshrc file not found in zshrc/. Skipping copy."
fi

log "Setup complete."
