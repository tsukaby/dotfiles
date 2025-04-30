#!/bin/zsh

rm -f ~/.gitconfig
ln -s $(pwd)/.gitconfig ~/.gitconfig

rm -f ~/.gitignore_global
ln -s $(pwd)/.gitignore_global ~/.gitignore_global

rm -f ~/.zshrc
ln -s $(pwd)/.zshrc ~/.zshrc

rm -f ~/.emacs
ln -s $(pwd)/.emacs ~/.emacs
