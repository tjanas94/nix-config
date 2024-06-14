{ pkgs, ... }:
let
  pass =
    pkgs.pass.withExtensions
      (exts: with exts; [ pass-import pass-otp pass-update ]);
in
{
  programs = {
    htop.enable = true;
    jq.enable = true;
    k9s.enable = true;
    password-store = {
      enable = true;
      package = pass;
    };
  };

  home.packages = with pkgs; [
    amazon-ecr-credential-helper
    android-tools
    ansible
    aws-azure-login
    awscli2
    btop
    buildah
    dnsutils
    docker-compose
    docker-credential-helpers
    duf
    duplicity
    expect
    fd
    fluxcd
    file
    glib
    gping
    imagemagick
    kind
    kubectx
    kubectl
    kubernetes-helm
    lazygit
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
    podman-compose
    poppler_utils
    procs
    pv
    pwgen
    qrencode
    rdiff-backup
    ripgrep
    samba
    screen
    skopeo
    socat
    sops
    vcsh
    wget
    whois
    unzip
    usbutils
    wol
    xdotool
    xkcdpass
    zbar
    zip
  ];
}
