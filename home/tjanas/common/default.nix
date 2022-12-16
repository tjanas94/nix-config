{outputs, ...}: {
  imports =
    [./cli ./gui]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = rec {
    username = "tjanas";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };

  xdg.enable = true;
  systemd.user.startServices = "sd-switch";
}
