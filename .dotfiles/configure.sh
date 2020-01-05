#!/usr/bin/env sh

#Make executable certain config files
chmod +x "$HOME/.config/sxhkd/sxhkdrc"

#Install packages, assumes Arch environment
sudo pacman -S --needed --noconfirm yay
yay -S --needed --noconfirm emacs open-dyslexic-fonts ttf-iosevka-etoile firefox firefox-tridactyl-native shadowfox-updater firefox-tridactyl-git isync fdm notmuch afew mu ffcast scrot devmon pandoc languagetool aspell-en rclone lpass plantuml qutebrowser python-pip bash-completion

#Fix permissions on fdm config so that it actually works
chmod 640 .fdm.conf
#Create mail directories
mkdir -p ~/.mail/work
mkdir -p ~/.mail/gmail
#Enable and run mbsync service
systemctl --user enable mbsync.service
systemctl --user enable mbsync.timer
systemctl --user start mbsync.timer

#Get org folder ready for sync
mkdir "$HOME/org"

#Immediately make Capslock into Super
setxkbmap -option caps:super
#Permanently map Capslock to Super
localectl set-x11-keymap us "" "" caps:super

#Load Doom Emacs package
git clone -b develop https://github.com/hlissner/doom-emacs "$HOME/.emacs.d"
"$HOME/.emacs.d/bin/doom" refresh

#Update protocol handlers, assumes gnomish environment
sudo ln -f -s "$HOME/.config/mimeapps.list" "$HOME/.local/share/applications/mimeapps.list"
update-desktop-database

#Recache Fonts
fc-cache

#Download Qute dictionaries
/usr/share/qutebrowser/scripts/dictcli.py install en-US

#Run shadowfox updater
shadowfox-updater -generate-uuids -set-dark-theme
