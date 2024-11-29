#!/usr/bin/env bash
xargs brew install < ./homebrew/leaves.txt
stow .
ln -sf ~/dotfiles/nvim/.nvim_config.lua ~/.nvim_config.lua
ln -sf ~/dotfiles/zshrc/.zshrc ~/.zshrc
