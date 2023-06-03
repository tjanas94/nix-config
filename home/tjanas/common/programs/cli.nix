{pkgs, ...}: let
  pass =
    pkgs.pass.withExtensions
    (exts: with exts; [pass-import pass-update]);
in {
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
    nodePackages.aws-azure-login
    age
    amazon-ecr-credential-helper
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
    imagemagick
    kubectx
    kubectl
    lynx
    moreutils
    mtr
    nmap
    openssl
    pandoc
    paperkey
    perl
    pciutils
    procs
    pv
    pwgen
    qrencode
    rdiff-backup
    ripgrep
    screen
    socat
    sops
    ssh-to-age
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
