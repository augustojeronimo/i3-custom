# Backup original files
cp -r .config/i3 .config/i3.backup

# System update
sudo pacman -Syu --noconfirm

# Instalation dependencies
sudo pacman -S --noconfirm feh picom terminator ttf-jetbrains-mono ttf-hack

# Copy dotfiles
cp ./i3status.conf ~/.config/i3/i3status.conf
cp ./config ~/.config/i3/config
