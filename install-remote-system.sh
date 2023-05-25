#!/usr/bin/env bash

set -exuo pipefail

if [ -z ${FLAKE+x} ]; then
    FLAKE=github:tjanas94/nix-config
fi

if [ $# -eq 0 ]; then
    echo "usage: $0 <host>" >&2
    exit 1
fi

HOST=$1

nixos-rebuild build --flake "$FLAKE#$HOST"
CLOSURE=$(readlink -f result)

export NIX_SSHOPTS='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
SSH="ssh $NIX_SSHOPTS"
GPG_SOCKET="$(gpgconf --list-dirs agent-extra-socket)"

$SSH \
    "root@$HOST" \
    "mkdir -p -m 0700 /root/.gnupg /run/user/0/gnupg"

$SSH \
    -R "/root/.gnupg/S.gpg-agent:$GPG_SOCKET" \
    -R "/run/user/0/gnupg/S.gpg-agent:$GPG_SOCKET" \
    "root@$HOST" \
    "SKIP_INSTALL=1 nix run $FLAKE#install-system -- $HOST"

nix copy --to "ssh://root@$HOST?remote-store=local?root=/mnt" "$CLOSURE"

$SSH \
    "root@$HOST" \
    "nixos-install --no-channel-copy --no-root-password --system $CLOSURE"

SRC=$(nix flake metadata "$FLAKE" --json | jq -r .path)

gpg -d "$SRC/config/gnupg/cryptkey.gpg" | $SSH \
    "root@$HOST" \
    "cat > /root/cryptkey"

pass "devices/$HOST/luks" | $SSH \
    "root@$HOST" \
    "cat | cryptsetup luksAddKey --key-file=/root/cryptkey /dev/disk/by-partlabel/root"
