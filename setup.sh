#!/bin/zsh

rm -f ~/.gitconfig
ln -s $(pwd)/.gitconfig ~/.gitconfig

rm -f ~/.gitignore_global
ln -s $(pwd)/.gitignore_global ~/.gitignore_global

rm -f ~/.zshrc
ln -s $(pwd)/.zshrc ~/.zshrc

rm -f ~/.emacs
ln -s $(pwd)/.emacs ~/.emacs

touch ~/.zshrc_secret

rm -f ~/Brewfile
ln -s $(pwd)/Brewfile ~/Brewfile

mkdir -p ~/.claude
rm -f ~/.claude/settings.json
ln -s $(pwd)/claude-settings.json ~/.claude/settings.json
