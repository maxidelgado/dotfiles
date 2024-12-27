#!/usr/bin/env bash

echo "🔧 Installing Homebrew packages from leaves.txt..."
xargs brew install < ./homebrew/leaves.txt && echo "✅ Homebrew packages installed."

echo "📦 Stowing dotfiles..."
stow . && echo "✅ Dotfiles stowed."

echo "📂 Creating code directories..."
mkdir -p ~/code/personal && echo "  - Created ~/code/personal"
mkdir -p ~/code/work/asapp && echo "  - Created ~/code/work/asapp"
echo "✅ Code directories set up."

echo "🔗 Symlinking configuration files..."
ln -sf ~/dotfiles/nvim/.nvim_config.lua ~/.nvim_config.lua && echo "  - Linked .nvim_config.lua"
ln -sf ~/dotfiles/zshrc/.zshrc ~/.zshrc && echo "  - Linked .zshrc"
ln -sf ~/dotfiles/ssh/config ~/.ssh/config && echo "  - Linked SSH config"
ln -sf ~/dotfiles/gitconfig/gitconfig ~/.gitconfig && echo "  - Linked .gitconfig"
ln -sf ~/dotfiles/gitconfig/gitconfig-personal ~/code/personal/.gitconfig-personal && echo "  - Linked .gitconfig-personal"
ln -sf ~/dotfiles/gitconfig/gitconfig-asapp ~/code/work/asapp/.gitconfig-asapp && echo "  - Linked .gitconfig-asapp"
echo "✅ Configuration files linked."

echo "🔑 Setting up 1Password agent socket..."
mkdir -p ~/.1password && echo "  - Ensured ~/.1password directory exists"
ln -sf ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock && echo "  - Linked 1Password agent.sock"
echo "✅ 1Password agent setup complete."

echo "🎉 All tasks completed successfully!"
