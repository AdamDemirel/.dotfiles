#!/bin/bash

# Before Install
## Install iso, burn with etcher or dd
## Check the checksum of the iso https://wiki.manjaro.org/index.php?title=Burn_an_ISO_File

# Connect to wifi first

echo "setting screen resolutions..."
xrandr --output HDMI1 --mode 2560x1440 # Desktop
xrandr --output eDP1 --mode 2460x1440 # Laptop

# echo "removing old dotfiles..."
# rm -rf ~/.dotfiles

echo "downloading new dotfiles..."
cd ~ && git clone git@github.com:AdamDemirel/.dotfiles.git

echo "fixing packmans gpg keys error..."
# find /var/cache/pacman/pkg/ -iname "*.part" -exec rm {} \;
# sudo pacman-key --populate archlinux
# sudo pacman -S archlinux-keyring --noconfirm
sudo pacman-mirrors --country all --api --protocols all --set-branch stable && sudo pacman -Syyu
# `sudo pacman-mirrors` to view, or `cat /etc/pacman.d/mirrorlist`

echo "updating time..."
sudo ntpdate -vu time.nist.gov

echo "upgrading arch..."
sudo pacman -Syyu --noconfirm

echo "installing all packman packages..."
image_viewer=gwenview
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

sudo pacman -S --noconfirm zsh $terminal_emulator git $image_viewer \
$image_editor gimp steam $audio_editor $shell $shell_text_editor \
$gui_text_editor $code_editor ksysguard $wallpaper_changer \
$video_player $image_capture $video_capture gparted etcher \
$pdf_viewer anki $skype_login_fix $skype_login_fix_gui \
discord libreoffice $file_manager fzf tldr whois httpie aws-cli \
ack tree git-lfs firefox kruler gvfs-smb zip flatpak \
solaar docker docker-compose gnome-screenshot dpkg # pandoc

echo "setting zsh as default shell... logout and login for it to take effect"
chsh -s $(which zsh)
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

echo "installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "installing zsh theme..."
source ~/.bashrc
mkdir -p $ZSH_CUSTOM/themes && curl https://raw.githubusercontent.com/jopcode/oh-my-zsh-bunnyruni-theme/master/bunnyruni.zsh-theme -L -o $ZSH_CUSTOM/themes/bunnyruni.zsh-theme

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
# audio_listener=banshee
# teleconference=zoom
bittorrent_client=transmission-gtk
gif_recorder=kazam
process_viewer=gotop

yaourt -S xflux-gui-git google-chrome skypeforlinux-stable-bin \
 slack-desktop $bittorrent_client $gif_recorder \
bat insomnia hub \ ttf-fira-code $process_viewer 
# xorg-xkill pgcli postman mongodb mongodb-compass calibre fondu heroku-cli
#  $audio_listener $teleconference

echo "installing and setting node..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc && source ~/.zshrc
nvm install 12.14.0
nvm alias default 12.14.0

echo "installing npm globals..."
npm i -g gulp create-next-app eslint eslint-plugin-prettier netlify-cli webpack babel-cli surge # react-static

echo "removing unused packages..."
sudo pacman -R dolphin dolphin-plugins kde-servicemenus-rootactions \
thunderbird

echo "installing vscode extensions..."
cat ~/.dotfiles/extensions.txt | xargs -n 1 code --install-extension

echo "setting up papirus icon theme..."
# https://wiki.archlinux.org/index.php/GTK%2B#Basic_theme_configuration
yaourt -S papirus-icon-theme
pkill thunar && rm -rf ~/.thumbnails ~/.cache/thumbnails # clears icon cache
sudo pacman -S lxappearance # set papirus through here, generates the correct GTKrc file https://bbs.archlinux.org/viewtopic.php?id=98261 (Papirus dark icon theme, Adwaita Widget style
echo "logout and login to update papirus icons"
# if all else fails, change /usr/share/gtk3.0/settings.ini to `Papirus` on both themes. And then resave papirus as icons in menu>icons (oldest solution)
# or `wget -qO- https://git.io/papirus-icon-theme-install | sh` from https://github.com/PapirusDevelopmentTeam/papirus-icon-theme

echo "setting flux up..."
# xflux -l -33.8 -k 2000 # Latitude 33.8 Longitude 151.11, 2000kelvins

echo "setting up wallpaper..."
rm -rf ~/Pictures/earthview
cd ~/.dotfiles/wallpapers && ./run.sh


echo "setting up symlinks..."
rm ~/.zshrc
rm ~/.gitconfig
rm ~/.yaourtrc
rm ~/.config/Code\ -\ OSS/User/settings.json
rm ~/.config/Code\ -\ OSS/User/keybindings.json
rm ~/.config/mimeapps.list
rm ~/.config/Code\ -\ OSS/User/snippets/javascript.json

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.yaourtrc ~/.yaourtrc
ln -s ~/.dotfiles/settings.json ~/.config/Code\ -\ OSS/User/settings.json
ln -s ~/.dotfiles/keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
ln -s ~/.dotfiles/mimeapps.list ~/.config/mimeapps.list
ln -s ~/.dotfiles/snippets/javascript.json ~/.config/Code\ -\ OSS/User/snippets/javascript.json


echo "configure manual steps in sync_down.sh"
code ~/.dotfiles/sync_down.sh
# Run these docker steps https://docs.docker.com/engine/install/linux-postinstall/
# in variety, set wallpaper directory to ~/Pictures/earthview
# set the global scale to 118.75% in the display preferences
# Change default shell in konsole to /bin/zsh
# Set konsole font to noto mono 16pt
# Set konsole profile to /bin/zsh instead of /bin/bash
# Map konsole close window to ctrl+w
# Skype -> settings -> general -> launch skype in the background
# Skype -> settings -> calling -> disable 'show call window when skype is in the bg'
# Start -> desktop session -> on login, start with an empty session
# Start -> Custom shortcuts -> Kmenuedit -> Launch console -> Trigger -> f12 reassign
# Start -> Global theme -> Breath2
# Minimise windows button to bottom right of taskbar
# `$ aws configure` to setup, then `aws s3 ls` to see buckets

echo "enable docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Generating SSH key and adding to GitHub..."
echo 'y' | ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N '' -C "adxm@msn.com"
GITHUB_SSH_KEY=$( cat ~/.ssh/id_rsa.pub )
curl -u "AdamDemirel" --data "{\"title\":\"manjaro\",\"key\": \"$GITHUB_SSH_KEY\" }" https://api.github.com/user/keys

echo "installing filesystem..."
cd ~/Documents
git clone git@github.com:AdamDemirel/fs.git .

# https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
