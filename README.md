# Arch linux
### Steps arch linux installation EFI
* Set Keymap
  * loadkeys KEYMAP
* Update the system clock
  * timedatectl set-ntp true
  * timedatectl status
* Partition the disks
  * Create partition efi
  * Create swap partition
  * Create root partition
* Format the partitions
  * mkfs.fat -F32 /dev/efi_partition
  * mkfs.ext4 /dev/root_partition
  * mkswap /dev/swap_partition
* Mount the file systems
  * swapon /dev/swap_partition
  * mount /dev/root_partition /mnt
  * mkdir -p /mnt/etc/boot
  * mount /dev/efi_partition /mnt/etc/boot
* Refresh mirrors
  * pacman -Syy
  * pacman -S reflector
  * cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  * reflector -c "<REGION\>" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
* Install essential packages
  * pacstrap /mnt base linux linux-firmware base-devel vim
* Configure the system
  * genfstab -U /mnt >> /mnt/etc/fstab
  * arch-chroot /mnt
  * ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
  * hwclock --systohc
  * Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed locales
  * locale-gen
  * Create the locale.conf(5) file, and set the LANG variable
    * Example
      * /etc/locale.conf
      * LANG=en_US.UTF-8
  * Set the keyboard layout, make the changes persistent in vconsole.conf
    * Example
      * /etc/vconsole.conf
      * KEYMAP=de-latin1
  * Create the hostname file
    * Example
      * /etc/hostname
      * myhostname
  * Add matching entries to hosts
    * Example
      * /etc/hosts
      * 127.0.0.1   localhost
      * ::1		      localhost
      * 127.0.1.1	  myhostname.localdomain	myhostname
* Configuration grub
  * pacman -S grub efibootmgr
  * grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
  * grub-mkconfig -o /boot/grub/grub.cfg
* Configuration user
  * pacman -S sudo
  * visudo
    * Uncomment wheel line
  * useradd -mG wheel <USER\>
* Finish installation
  * exit
  * umount -R /mnt
  * reboot
