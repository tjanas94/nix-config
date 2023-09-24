#!/usr/bin/env bash

set -exuo pipefail

export NIX_CONFIG='
experimental-features = nix-command flakes repl-flake
accept-flake-config = true
'

if [ -z ${FLAKE+x} ]; then
    FLAKE=github:tjanas94/nix-config
fi

if [ $UID -ne 0 ]; then
    echo "must be run as root" >&2
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "usage: $0 <host>" >&2
    exit 1
fi

HOST=$1

if ! nix flake show --json "$FLAKE" | jq -e '.nixosConfigurations["'"$HOST"'"].type == "nixos-configuration"'; then
    echo "nixos configuration $HOST does not exist" >&2
    exit 1
fi

SRC=$(nix flake metadata "$FLAKE" --json | jq -r .path)

# shellcheck source=/dev/null
source "$SRC/hosts/$HOST/config.sh"

TMPDIR="$(mktemp -d)"
trap 'rm -rf $TMPDIR' EXIT

if [ -S "$(gpgconf --list-dirs agent-socket)" ]; then
    gpg --import "$SRC/config/gnupg/public.asc"
else
    GPG_TTY=$(tty)
    GNUPGHOME="$TMPDIR/gnupg"
    export GPG_TTY GNUPGHOME

    mkdir -p "$GNUPGHOME"
    echo "pinentry-program $(command -v pinentry-curses)" >"$GNUPGHOME/gpg-agent.conf"
    gpg --import "$SRC/config/gnupg/public.asc"
    gpg --card-status
fi

umask 0077
gpg -d "$SRC/config/gnupg/cryptkey.gpg" >"$TMPDIR/crypto_keyfile.bin"
gpg -d "$SRC/hosts/$HOST/ssh_host_ed25519_key.gpg" >"$TMPDIR/ssh_host_ed25519_key"
umask 0022

parted -s "$DEV" -- mklabel gpt
parted "$DEV" -- mkpart 'bios-grub' 1MiB 2MiB
parted "$DEV" -- mkpart 'boot' 2MiB 512MiB
parted "$DEV" -- mkpart 'root' 512MiB 100%
parted "$DEV" -- set 1 bios_grub on
parted "$DEV" -- set 2 esp on

while [ ! -b /dev/disk/by-partlabel/root ]; do
    sleep 1
done

cryptsetup luksFormat --batch-mode /dev/disk/by-partlabel/root "$TMPDIR/crypto_keyfile.bin"
cryptsetup open --key-file "$TMPDIR/crypto_keyfile.bin" /dev/disk/by-partlabel/root luks-root
mkfs.btrfs -L 'nixos-system' /dev/mapper/luks-root
mkfs.vfat -n boot /dev/disk/by-partlabel/boot

while [ ! -b /dev/disk/by-label/nixos-system ]; do
    sleep 1
done

mount /dev/disk/by-label/nixos-system /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/persist
btrfs subvolume create /mnt/log
btrfs subvolume create /mnt/swap
chattr +C /mnt/swap
btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
umount /mnt

mount -o subvol=root,compress=zstd,noatime /dev/disk/by-label/nixos-system /mnt
mkdir -p /mnt/{boot,home,nix,persist,var/log,swap,backup/local-system}
mount -o subvol=home,compress=zstd /dev/disk/by-label/nixos-system /mnt/home
mount -o subvol=nix,compress=zstd,noatime /dev/disk/by-label/nixos-system /mnt/nix
mount -o subvol=persist,compress=zstd,noatime /dev/disk/by-label/nixos-system /mnt/persist
mount -o subvol=log,compress=zstd,noatime /dev/disk/by-label/nixos-system /mnt/var/log
mount -o subvol=swap,noatime /dev/disk/by-label/nixos-system /mnt/swap
mount -o noatime /dev/disk/by-label/boot /mnt/boot

mkdir -p /mnt/persist/etc/ssh
cp -t /mnt/persist/etc/ssh "$TMPDIR/ssh_host_ed25519_key"

if [ -z ${SKIP_INSTALL+x} ]; then
    nixos-install --no-channel-copy --no-root-password --flake "$FLAKE#$HOST"
fi
