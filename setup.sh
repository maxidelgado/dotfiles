#!/usr/bin/env bash
xargs brew install < ./homebrew/leaves.txt
stow .
ln -sf ~/dotfiles/nvim/.nvim_config.lua ~/.nvim_config.lua
ln -sf ~/dotfiles/zshrc/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config
mkdir -p ~/.1password && ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
