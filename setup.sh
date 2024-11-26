#!/usr/bin/env bash
stow .
ln -sf ./nvim/.nvim_config.lua ~/.nvim_config.lua
ln -sf ./zshrc/.zshrc ~/.zshrc
