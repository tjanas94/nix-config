{ pkgs, ... }: {
  programs = {
    bat.enable = true;
    broot = {
      enable = true;
      settings.modal = true;
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
      keyScheme = "vim";
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions
        (exts: with exts; [ pass-import pass-otp pass-update ]);
    };
  };

  home.packages = with pkgs; [
    nodePackages.aws-azure-login
    amazon-ecr-credential-helper
    awscli2
    binutils
    btop
    choose
    docker-compose
    docker-credential-helpers
    dogdns
    duf
    fd
    fluxcd
    fx
    file
    go
    gping
    httpie
    inotify-tools
    jc
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
    perl
    pciutils
    procs
    python3Full
    pv
    ripgrep
    screen
    sd
    vcsh
    wget
    unzip
    usbutils
    zip
  ];
}
