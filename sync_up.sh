#!/usr/bin/bash

echo "generating vscode extension list..."
code --list-extensions >> ~/.dotfiles/extensions.txt

git add .
git commit -m "sync up"
git push origin master
