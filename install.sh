#!/usr/bin/env bash

yay -S --noconfirm polybar siji-git ttf-font-awesome ttf-jetbrains-mono

sudo pacman -S --noconfirm lxappearance bluez buez-utils intel-ucode \
		networkmanager network-manager-applet dialog wpa_supplicant \
		mtools dosfstools reflector avahi xdg-user-dirs \
		xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils cups \
		hplip alsa-utils pipewire pipewire-alsa pipewire-pulse \
		pipewire-jack openssh rsync acpi acpi_call edk2-ovmf \
		bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft \
		ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g

echo "Enabling services"

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

DIR_BSPWM = "~/.config/bspwm/"
DIR_SXHKD = "~/.config/sxhkd/"
DIR_POLYBAR = "~/.config/polybar"
DIR_ALACRITTY = "~/.config/alacritty"

copy_dotfiles() {
    cp .config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
    cp .config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
    cp .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
    cp .config/polybar/config ~/.config/polybar/config
    cp .config/polybar/launch.sh ~/.config/polybar/launch.sh
}

make_directories() {
    mkdir -p ~/.config/{bspwm,sxhkd,alacritty,polybar}
}

if [[ -d "$DIR_BSPWM" && -d "$DIR_SXHKD" && -d "$DIR_POLYBAR" && -d "$DIR_ALACRITTY" ]]; then
    copy_dotfiles
else
    make_directories
    copy_dotfiles
fi

echo "Add intel microcode"
sudo grub-mkconfig -o /boot/grub/grub.cfg
