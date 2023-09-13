
# Cannot be run as root
if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

# Define packages
dependencias=(base-devel rustup pacman-contrib bspwm polybar sxhkd \
			  alacritty brightnessctl dunst rofi lsd \
			  git picom maim xdg-user-dirs \
			  xorg-xprop xorg-xkill physlock papirus-icon-theme \
			  ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels \
			  zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting xorg-xsetroot xorg-xwininfo xorg-xrandr \
			  lxappearance arandr nemo ntfs-3g)

is_installed() {
  pacman -Qi "$1" &> /dev/null
  return $?
}

for paquete in "${dependencias[@]}"
do
  if ! is_installed "$paquete"; then
    sudo pacman -S "$paquete" --noconfirm
    printf "\n"
  else
    sleep 1
  fi
done
sleep 3
clear

# Preparing Folders
if [ ! -e $HOME/.config/user-dirs.dirs ]; then
	xdg-user-dirs-update
	echo "Creating xdg-user-dirs"
else
	echo "user-dirs.dirs already exists"
fi
sleep 2 
clear

# Cloning Rice
cd
git clone --depth=1 https://github.com/gh0stzk/dotfiles.git
sleep 2
clear


# Copy Rice
[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts

for archivos in ~/dotfiles/config/*; do
  cp -R "${archivos}" ~/.config/
  if [ $? -eq 0 ]; then
	printf "%s%s%s folder copied succesfully!%s\n"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n"
	sleep 1
  fi
done

for archivos in ~/dotfiles/fonts/*; do
  cp -R "${archivos}" ~/.local/share/fonts/
  if [ $? -eq 0 ]; then
	printf "%s%s%s copied succesfully!%s\n"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n"
	sleep 1
  fi
done

cp -f "$HOME"/dotfiles/home/.zshrc "$HOME"
fc-cache -rv >/dev/null 2>&1
printf "%s%sFiles copied succesfully!!%s\n"
sleep 3

# Install Paru
if ! command -v paru >/dev/null 2>&1; then
	printf "%s%sInstalling paru%s\n"
	cd
	git clone https://aur.archlinux.org/paru-bin.git
	cd paru-bin
	makepkg -si --noconfirm
	cd
else
	printf "%s%sParu is already installed%s\n"
fi

#Change shell to zsh
printf "%s%sIf your shell is not zsh will be changed now.\nYour root password is needed to make the change.\n\nAfter that is important for you to reboot.\n %s\n"
if [[ $SHELL != "/usr/bin/zsh" ]]; then
  echo "Changing shell to zsh, your root pass is needed."
  chsh -s /usr/bin/zsh
else
  printf "%s%sYour shell is already zsh\nGood bye! installation finished, now reboot%s\n"
  zsh
fi