{pkgs, ...}: {
  programs = {
    bat = {
      enable = true;
      config.theme = "gruvbox-dark";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    fzf = {
      enable = true;
      defaultCommand = "fd -t f";
      changeDirWidgetCommand = "fd -t d";
    };
    htop.enable = true;
    info.enable = true;
    jq.enable = true;
    k9s.enable = true;
    less.enable = true;
    mcfly = {
      enable = true;
      fuzzySearchFactor = 2;
    };
    password-store = {
      enable = true;
      package =
        pkgs.pass.withExtensions
        (exts: with exts; [pass-import pass-otp pass-update]);
    };
  };

  home.packages = with pkgs; [
    nodePackages.aws-azure-login
    python3Packages.grip
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
    editorconfig-core-c
    fd
    fluxcd
    file
    go
    imagemagick
    jdk
    kubectx
    kubectl
    lynx
    maven
    moreutils
    mtr
    nmap
    node2nix
    nodejs
    openssl
    pandoc
    perl
    pciutils
    procs
    python3Full
    pv
    rdiff-backup
    ripgrep
    screen
    socat
    vcsh
    wget
    unzip
    usbutils
    zip
  ];

  xdg.configFile.Yubico = {
    source = ../../../../config/Yubico;
    recursive = true;
  };
}
