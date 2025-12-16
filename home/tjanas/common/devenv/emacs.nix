{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs:
      with epkgs; [
        ef-themes
        magit
        nix-mode
        ob-http
        paredit
        slime
        treesit-grammars.with-all-grammars
        which-key
      ];
  };

  services.emacs = {
    enable = true;
    startWithUserSession = false;
  };

  xdg.configFile.emacs.source = config.lib.file.mkOutOfStoreSymlink "/home/tjanas/workspace/github.com/tjanas94/nix-config/master/config/emacs";
}
