#!/usr/bin/env bash

set -euo pipefail

if [ $# -lt 2 ]; then
    echo "usage: $0 <hosts> <command> [options ...]" >&2
    exit 1
fi

HOSTS=$1
shift

for host in $HOSTS; do
    nixos-rebuild --flake ".#$host" --target-host "root@$host" --use-substitutes "$@"
done
