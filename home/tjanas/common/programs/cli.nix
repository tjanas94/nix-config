{ pkgs, ... }:
let
  pass =
    pkgs.pass.withExtensions
      (exts: with exts; [ pass-import pass-update ]);
in
{
  programs = {
    htop.enable = true;
    jq.enable = true;
    k9s.enable = true;
    password-store.enable = true;
  };

  home.packages = with pkgs; [
    amazon-ecr-credential-helper
    aws-azure-login
    ansible
    awscli2
    binutils
    btop
    dnsutils
    docker-compose
    docker-credential-helpers
    duf
    duplicity
    fd
    fluxcd
    file
    glib
    gping
    imagemagick
    kubectx
    kubectl
    lynx
    moreutils
    mtr
    ncdu
    nmap
    openssl
    p7zip
    pandoc
    paperkey
    perl
    pciutils
    poppler_utils
    procs
    pv
    pwgen
    qrencode
    rdiff-backup
    ripgrep
    screen
    samba
    socat
    vcsh
    wget
    whois
    unzip
    usbutils
    wol
    xkcdpass
    zbar
    zip
  ];
}
