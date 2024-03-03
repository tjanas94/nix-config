{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        magit
        ob-http
        which-key
      ];
  };

  services.emacs.enable = true;

  xdg.configFile.emacs = {
    source = ../../../../config/emacs;
    recursive = true;
  };
}
