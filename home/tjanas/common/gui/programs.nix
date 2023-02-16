{pkgs, ...}: let
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
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg.enableTridactylNative = true;
        extraNativeMessagingHosts = [pkgs.passff-host];
      };
    };
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
    libreoffice
    networkmanagerapplet
    pavucontrol
    pgadmin4
    playerctl
    postman
    pulsemixer
    remmina
    scrot
    simple-scan
    teams
    thunar
    transmission-gtk
    virt-manager
    winetricks
    wineWowPackages.stable
    wireshark
    xsel
    yubikey-manager
    yubikey-manager-qt
  ];
}
