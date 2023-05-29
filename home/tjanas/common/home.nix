{
  home = rec {
    username = "tjanas";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };

  xdg.enable = true;
  systemd.user.startServices = "sd-switch";
}
