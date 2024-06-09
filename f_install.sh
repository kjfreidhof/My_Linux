#!/usr/bin/env bash 
set -e
# base packages to install based on the filesystem choosen below
base_btrfs=("base", "base-devel", "linux-firmware", "linux", "linux-lts", "btrfs-progs")
base_ext4=("base", "base-devel", "linux-firmware", "linux", "linux-lts", "e2fsprogs")
base_xfs=("base","base-devel", "linux-firmware", "linux", "linux-lts", "xfsprogs")
# The name of my main disk.
disk="/dev/sda"
# Region and time 
time="timedatectl set-ntp true"
region="/usr/share/zoneinfo/America/New_York"
loc="/etc/localtime"
en_US="en_US.UTF-8 UTF-8"
# packages to install when in arch-chroot environment
pkgs=("vim" "networkmanager" "grub" "efibootmgr" "dosfstools" "os-prober" "mtools" "git" "terminus-font")

# boot directory
boot_dir="/boot/EFI"
# installing grub
grub_install="grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck"
grub_config="grub-mkconfig -o /boot/grub/grub.cfg"

Install_arch() {
	if [ -d /sys/firmware/efi ]; then 
		$time 
		echo "[B/b]: btrfs"
		echo "[E/e]: ext4"
		echo "[x/X]: xfs"

		read -rp "Enter the file system you want to use"  option
		if [ "$option" = "b" ] || [ "$option" = "B"] || [ "$option" = "btrfs"];  then 
			parted "$disk" --script mklabel gpt 
			parted "$disk" --script mkpart primary fat32 1MiB 512MiB
			parted "$disk" --script set 1 esp on 
			parted "$disk" --script mkpart primary btrfs 512MiB 100%
		       	mkfs.fat -F 32 ${disk}1
			mkfs.btrfs ${disk}2
			mount ${disk}2 /mnt
			pacstrap -K /mnt "${base_btrfs[@]}"
			genfstab -U /mnt >> /mnt/etc/fstab
			read -rp "What do you want your hostname to be: " hostname
			read -rp "What do you want the username to be: " user
			arch-chroot /mnt /bin/bash  -c "
			ln -sf "$region" "$loc"
			hwclock --systohc 
			echo "$en_US" >> /etc/locale.gen
			locale-gen
			echo "$hostname" > /etc/hostname 
			echo '127.0.0.1		localhost' >> /etc/hosts
			echo '::1		localhost' >> /etc/hosts 
			echo "127.0.1.1		$hostname.localdomain	$hostname" >> /etc/hosts 

			echo 'Enter password for root user'
			echo 'Enter username then Enter password for the user '
			passwd && useradd -m "$user" && passwd $user 
			usermod -aG wheel,audio,video,optical,storage "$user"
			sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers 
			pacman -S "${pkgs[@]}"
			"$grub_install" && "$grub_config"
			exit 
			"
			umount -R /mnt 
			read -rp "Do you want to reboot [y/n]: " choice

			if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then 
				reboot 


			else 
				return



			fi 
							



		elif [ "$option" = "e" ] || [ "$option" = "E" ] || [ "$option" = "ext4" ]; then
			parted "$disk" --script mklabel gpt
			parted "$disk" --script mkpart primary fat32 1MiB 512MiB
			parted "$disk" --script set 1 esp on 
			parted "$disk" --script mkpart primary ext4 512MiB 100%
		        mkfs.fat -F 32 ${disk}1
			mkfs.ext4 ${disk}2
			mount ${disk}2 /mnt 
			pacstrap -K /mnt "${base_ext4[@]}"
			read -rp "What do you want your hostname to be: " hostname
			read -rp "What do you want the username to be: " user
			arch-chroot /mnt /bin/bash  -c "
			ln -sf "$region" "$loc"
			hwclock --systohc 
			echo "$en_US" >> /etc/locale.gen
			locale-gen
			echo "$hostname" > /etc/hostname 
			echo '127.0.0.1		localhost' >> /etc/hosts
			echo '::1		localhost' >> /etc/hosts 
			echo "127.0.1.1		$hostname.localdomain	$hostname" >> /etc/hosts 

			echo 'Enter password for root user'
			echo 'Enter username then Enter password for the user '
			passwd && useradd -m "$user" && passwd $user 
			usermod -aG wheel,audio,video,optical,storage "$user"
			sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers 
			pacman -S "${pkgs[@]}"
			"$grub_install" && "$grub_config"
			exit 
			"
			umount -R /mnt 
			read -rp "Do you want to reboot [y/n]: " choice

			if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then 
				reboot 


			else 
				return



			fi 
			
	       		

		elif [ "$option" = "x" ] || [ "$option" = "X" ] || [ "$option" = "xfs" ]; then 
			parted "$disk" --script mklabel gpt
			parted "$disk" --script mkpart primary fat32 1MiB 512MiB
			parted "$disk" --script set 1 esp on 
			parted "$disk" --script mkpart primary xfs 512MiB 100%
		        mkfs.fat -F 32 ${disk}1
			mkfs.xfs ${disk}2
			mount ${disk}2 /mnt 
			pacstrap -K /mnt "${base_xfs[@]}"
			read -rp "What do you want your hostname to be: " hostname
			read -rp "What do you want the username to be: " user
			arch-chroot /mnt /bin/bash  -c "
			ln -sf "$region" "$loc"
			hwclock --systohc 
			echo "$en_US" >> /etc/locale.gen
			locale-gen
			echo "$hostname" > /etc/hostname 
			echo '127.0.0.1		localhost' >> /etc/hosts
			echo '::1		localhost' >> /etc/hosts 
			echo "127.0.1.1		$hostname.localdomain	$hostname" >> /etc/hosts 

			echo 'Enter password for root user'
			echo 'Enter username then Enter password for the user '
			passwd && useradd -m "$user" && passwd $user 
			usermod -aG wheel,audio,video,optical,storage "$user"
			sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers 
			pacman -S "${pkgs[@]}"
			"$grub_install" && "$grub_config"
			exit 
			"
			umount -R /mnt 
			read -rp "Do you want to reboot [y/n]: " choice

			if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then 
				reboot 


			else 
				return



			fi 
			


		else 
			printf "Error: Wrong Option Choose [x,X,xfs or e,E,ext4 or b,B,btrfs].\n"
			return 1

		fi 




	else
	       printf "Error: Not using UEFI this script is meant for UEFI only \n"
       	       return 1	       



	fi 
}
Install_arch 
