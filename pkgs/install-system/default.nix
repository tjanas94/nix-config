{
  stdenv,
  lib,
  makeWrapper,
  pkgs,
}: let
  runtimeInputs = with pkgs; [
    btrfs-progs
    coreutils
    cryptsetup
    dosfstools
    e2fsprogs
    git
    gnupg
    jq
    nix
    nixos-install-tools
    parted
    pinentry-curses
    util-linux
  ];
in
  stdenv.mkDerivation {
    pname = "install-system";
    version = "master";
    src = ./.;
    buildInputs = runtimeInputs;
    nativeBuildInputs = [makeWrapper];
    installPhase = ''
      runHook preInstall

      install -DTm 0755 install-system.sh $out/bin/install-system

      wrapProgram $out/bin/install-system \
        --set PATH ${lib.makeBinPath runtimeInputs}

      runHook postInstall
    '';
  }
