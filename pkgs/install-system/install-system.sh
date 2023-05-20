#!/usr/bin/env bash

set -euo pipefail

export NIX_CONFIG='experimental-features = nix-command flakes'

FLAKE=github:tjanas94/nix-config

if [ $UID -ne 0 ]; then
	echo "must be run as root" >&2
	exit 1
fi

if [ $# -ne 1 ]; then
	echo "usage: $0 <host>" >&2
	exit 1
fi

HOST=$1

if ! nix flake show --json "$FLAKE" | jq -e ".nixosConfigurations.${HOST}.type == \"nixos-configuration\""; then
	echo "nixos configuration $HOST does not exist" >&2
	exit 1
fi

SRC=$(nix flake metadata "$FLAKE" --json | jq -r .path)

# shellcheck source=/dev/null
source "$SRC/hosts/$HOST/config.sh"

cd "$(mktemp -d)"

if [ ! -S "$(gpgconf --list-dirs agent-socket)" ]; then
	GPG_TTY=$(tty)
	GNUPGHOME="$(pwd)/gnupg"
	export GPG_TTY GNUPGHOME

	mkdir -p "$GNUPGHOME"
	echo "pinentry-program $(command -v pinentry-curses)" >"$GNUPGHOME/gpg-agent.conf"
	gpg --import "$SRC/config/gnupg/public.asc"
	gpg --card-status
fi

umask 0077
gpg -d "$SRC/config/gnupg/cryptkey.gpg" >crypto_keyfile.bin
gpg -d "$SRC/hosts/$HOST/ssh_host_ed25519_key.gpg" >ssh_host_ed25519_key
umask 0022

parted "$DEV" -- mklabel gpt
parted "$DEV" -- mkpart 'bios-grub' 1MiB 2MiB
parted "$DEV" -- mkpart 'boot' 2MiB 1GiB
parted "$DEV" -- mkpart 'root' 1GiB 100%
parted "$DEV" -- set 1 bios_grub on
parted "$DEV" -- set 2 esp on
udevadm trigger

cryptsetup luksFormat --batch-mode /dev/disk/by-partlabel/root crypto_keyfile.bin
cryptsetup open --key-file crypto_keyfile.bin /dev/disk/by-partlabel/root luks-root

mkfs.btrfs -L 'nixos-system' /dev/mapper/luks-root
mount /dev/mapper/luks-root /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persist
btrfs subvolume create /mnt/log
btrfs subvolume create /mnt/swap
chattr +C /mnt/swap
btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
umount /mnt

mount -o subvol=root,compress=zstd,noatime /dev/mapper/luks-root /mnt
mkdir -p /mnt/{boot,home,nix,persist,var/log,swap}
mount -o subvol=home,compress=zstd /dev/mapper/luks-root /mnt/home
mount -o subvol=nix,compress=zstd,noatime /dev/mapper/luks-root /mnt/nix
mount -o subvol=persist,compress=zstd,noatime /dev/mapper/luks-root /mnt/persist
mount -o subvol=log,compress=zstd,noatime /dev/mapper/luks-root /mnt/var/log
mount -o subvol=swap,noatime /dev/mapper/luks-root /mnt/swap

mkfs.vfat -n boot /dev/disk/by-partlabel/boot
mount -o noatime /dev/disk/by-partlabel/boot /mnt/boot

mkdir -p /mnt/persist/etc/ssh
mv -t /mnt/persist/etc/ssh ssh_host_ed25519_key "$SRC/hosts/$HOST/ssh_host_ed25519_key.pub"
mv -t /mnt/persist crypto_keyfile.bin

nixos-install --no-root-password --flake "$FLAKE#$HOST"
