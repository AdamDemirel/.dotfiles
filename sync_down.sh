#!/bin/bash

echo "setting screen resolutions..."
xrandr --output HDMI-1 --mode 2560x14 # Desktop
xrandr --output eDP-1 --mode 1600x900 # Laptop

echo "removing old dotfiles..."
rm -rf ~/.dotfiles

echo "downloading new dotfiles..."
cd ~ && git clone git@github.com:AdamDemirel/.dotfiles.git

echo "setting up symlinks..."
rm ~/.zshrc
rm ~/.gitconfig
rm ~/.yaourtrc
rm ~/.config/Code\ -\ OSS/User/settings.json
rm ~/.config/Code\ -\ OSS/User/keybindings.json
rm ~/.config/mimeapps.list

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.yaourtrc ~/.yaourtrc
ln -s ~/.dotfiles/settings.json ~/.config/Code\ -\ OSS/User/settings.json
ln -s ~/.dotfiles/keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
ln -s ~/.dotfiles/mimeapps.list ~/.config/mimeapps.list

echo "fixing packmans gpg keys error..."
find /var/cache/pacman/pkg/ -iname "*.part" -exec rm {} \; 
sudo pacman-key --populate archlinux
sudo pacman -S archlinux-keyring

echo "updating time..."
sudo ntpdate -vu time.nist.gov

echo "upgrading arch..."
sudo pacman -Syyu --noconfirm

echo "installing all packman packages..."
image_viewer=ristretto
image_editor=mypaint
terminal_emulator=konsole
audio_editor=ffmpeg
shell=zsh
shell_text_editor=nano
gui_text_editor=kate
code_editor=code
wallpaper_changer=variety
video_player=vlc
image_capture=cheese
video_capture=obs-studio
pdf_viewer=okular
skype_login_fix=gnome-keyring
skype_login_fix_gui=seahorse
file_manager=thunar

sudo pacman -S --noconfirm $terminal_emulator git $image_viewer \
$image_editor gimp steam $audio_editor $shell $shell_text_editor \
$gui_text_editor $code_editor htop ksysguard $wallpaper_changer \
$video_player $image_capture $video_capture gparted etcher \
$pdf_viewer anki $skype_login_fix $skype_login_fix_gui \
discord libreoffice $file_manager fzf

echo "installing yaourt..."
sudo pacman -S --needed base-devel git wget yajl --noconfirm
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/ --noconfirm
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si --noconfirm
sudo rm -rf package-query yaourt

echo "installing all yoghurt packages..."
audio_listener=banshee
teleconference=zoom
bittorrent_client=transmission-gtk
gif_recorder=kazam
yaourt -S fluxgui google-chrome xorg-xkill skypeforlinux-stable-bin $audio_listener \
oh-my-zsh-git $teleconference slack-desktop $bittorrent_client $gif_recorder \

echo "removing unused packages..."
sudo pacman -R dolphin dolphin-plugins kde-servicemenus-rootactions \
thunderbird

echo "installing zsh theme..."
mkdir -p $ZSH_CUSTOM/themes && curl https://raw.githubusercontent.com/jopcode/oh-my-zsh-bunnyruni-theme/master/bunnyruni.zsh-theme -L -o $ZSH_CUSTOM/themes/bunnyruni.zsh-theme

echo "installing vscode extensions..."
cat ~/.dotfiles/extensions.txt | xargs -n 1 code --install-extension

echo "setting up papirus icon theme..."
# https://wiki.archlinux.org/index.php/GTK%2B#Basic_theme_configuration
yaourt -S papirus-icon-theme
pkill thunar && rm -rf ~/.thumbnails ~/.cache/thumbnails # clears icon cache
sudo pacman -S lxappearance # set papirus through here, generates the correct GTKrc file https://bbs.archlinux.org/viewtopic.php?id=98261
echo "Logout and login to update papirus icons"
# if all else fails, change /usr/share/gtk3.0/settings.ini to `Papirus` on both themes. And then resave papirus as icons in menu>icons (oldest solution)
# or `wget -qO- https://git.io/papirus-icon-theme-install | sh` from https://github.com/PapirusDevelopmentTeam/papirus-icon-theme

echo "setting flux up..."
xflux -l 33.7502 -k 2000
