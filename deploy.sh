#!/usr/bin/env bash

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "usage: $0 <hosts> [options ...]" >&2
    exit 1
fi

HOSTS=$1
shift

for host in $HOSTS; do
    nixos-rebuild --flake ".#$host" switch --target-host "root@$host" --use-substitutes "$@"
done
