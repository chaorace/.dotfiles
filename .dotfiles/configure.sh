#!/usr/bin/env sh

#Make executable certain config files
chmod +x "$HOME/.config/sxhkd/sxhkdrc"

#Install packages, assumes Arch environment
sudo pacman -S --needed --noconfirm yay
yay -S --needed --noconfirm emacs open-dyslexic-fonts ttf-iosevka-etoile firefox firefox-tridactyl-native shadowfox-updater firefox-tridactyl-git isync fdm notmuch afew mu ffcast scrot devmon pandoc languagetool

#Enable and run mbsync service
systemctl --user enable mbsync.service
systemctl --user enable mbsync.timer
systemctl --user start mbsync.timer

#Load Doom Emacs package
git clone -b develop https://github.com/hlissner/doom-emacs "$HOME/.emacs.d"
"$HOME/.emacs.d/bin/doom" refresh

#Cache protocol handlers, assumes gnomish environment
update-desktop-database "$HOME/.local/share/applications/"

#Recache Fonts
fc-cache

#Run shadowfox updater
shadowfox-updater -generate-uuids -set-dark-theme

#Cycle firefox once (applies GUI changes from tridactyl)
firefox &
sleep 10 && killall firefox
