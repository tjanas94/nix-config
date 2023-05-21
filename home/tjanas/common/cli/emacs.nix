{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [epkgs.vterm];
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
  };

  home = {
    packages = with pkgs; [
      emacs-all-the-icons-fonts
    ];

    sessionPath = ["$XDG_CONFIG_HOME/emacs/bin"];
  };

  xdg.configFile.doom = {
    source = ../../../../config/doom;
    recursive = true;
  };
}
