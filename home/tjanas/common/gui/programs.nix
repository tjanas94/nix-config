{
  inputs,
  pkgs,
  ...
}: let
  mpv =
    pkgs.wrapMpv (pkgs.mpv-unwrapped.override {
      pipewireSupport = false;
      vapoursynthSupport = true;
    }) {
      scripts = with pkgs.mpvScripts; [mpris sponsorblock youtube-quality];
      youtubeSupport = true;
    };
  thunar = pkgs.xfce.thunar.override {
    thunarPlugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };
in {
  programs = {
    brave.enable = true;
    browserpass.enable = true;
    firefox.enable = true;
    google-chrome.enable = true;

    mpv = {
      enable = true;
      package = mpv;
    };

    rofi = {
      enable = true;
      theme = "gruvbox-dark";
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };

    vscode.enable = true;
    yt-dlp.enable = true;
  };

  services = {
    unclutter.enable = true;

    xcape = {
      enable = true;
      mapExpression = {Caps_Lock = "Escape";};
    };
  };

  home.packages = with pkgs; [
    android-tools
    arandr
    feh
    filezilla
    gimp
    inkscape
    jetbrains.idea-community
    keepassxc
    libnotify
    libreoffice-fresh
    networkmanagerapplet
    pavucontrol
    pgadmin4
    playerctl
    postman
    pulsemixer
    remmina
    scrot
    simple-scan
    nixpkgs-master.teams
    thunar
    transmission-gtk
    trezor-suite
    virt-manager
    wireshark
    xsel
    yubikey-manager
    yubikey-manager-qt
  ];
}
