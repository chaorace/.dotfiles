#!/usr/bin/env sh

#Install packages, assumes Arch environment
sudo pacman -S --needed emacs open-dyslexic-fonts

#Load Doom Emacs package
git clone -b develop https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom refresh

#Recache Fonts
fc-cache
