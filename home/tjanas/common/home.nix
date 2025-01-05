{
  home = rec {
    username = "tjanas";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
  };
  systemd.user.startServices = "sd-switch";
}
