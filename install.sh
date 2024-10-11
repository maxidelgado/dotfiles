#!/usr/bin/env bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
xargs brew install < homebrew/leaves.txt
xargs brew cask < homebrew/casks.txt
stow .
cp zshrc/.zshrc ~/.zshrc