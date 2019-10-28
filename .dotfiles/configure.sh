#!/usr/bin/env sh

#Install packages, assumes Arch environment
yay -S --needed --noconfirm emacs open-dyslexic-fonts firefox firefox-tridactyl-native shadowfox-updater firefox-tridactyl-git

#Enable and run mbsync service
systemctl --user enable mbsync.service
systemctl --user enable mbsync.timer
systemctl --user start mbsync.timer

#Load Doom Emacs package
git clone -b develop https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom refresh

#Recache Fonts
fc-cache

#Run shadowfox updater
shadowfox-updater -generate-uuids -set-dark-theme

#Cycle firefox once (applies GUI changes from tridactyl)
firefox &
sleep 10 && killall firefox
