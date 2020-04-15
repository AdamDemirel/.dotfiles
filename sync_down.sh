#!/usr/bin/bash

echo "removing old dotfiles..."
rm -rf ~/.dotfiles

echo "downloading new dotfiles..."
cd ~ && git clone git@github.com:AdamDemirel/.dotfiles.git

echo "setting up symlinks"
ln -s ~/.zshrc ~/.dotfiles/.zshrc

# git clone git@github.com:AdamDemirel/.dotfiles.git

# alias sync_down="cat /home/adam/.config/Code - OSS/User/extensions.txt"
