#!/usr/bin/env bash

set -exuo pipefail

nix flake update

cd pkgs/node-packages
node2nix --pkg-name nodejs -i node-packages.json

git add -A
pre-commit || true
git add -A
git commit -m 'System update'
