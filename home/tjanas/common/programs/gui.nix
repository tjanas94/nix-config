{ inputs
, pkgs
, ...
}:
let
  mpv =
    pkgs.wrapMpv
      (pkgs.mpv-unwrapped.override {
        pipewireSupport = false;
        vapoursynthSupport = true;
      })
      {
        scripts = with pkgs.mpvScripts; [ mpris sponsorblock quality-menu ];
        youtubeSupport = true;
      };
  thunar = pkgs.xfce.thunar.override {
    thunarPlugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };
in
{
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

  home.packages = with pkgs; [
    filezilla
    gimp
    inkscape
    jetbrains.idea-community
    keepassxc
    libnotify
    libreoffice-fresh
    networkmanagerapplet
    pavucontrol
    playerctl
    pulsemixer
    remmina
    simple-scan
    thunar
    trezor-suite
    virt-manager
    wireshark
    yubikey-manager
    yubikey-manager-qt
  ];
}
