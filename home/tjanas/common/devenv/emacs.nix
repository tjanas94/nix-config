{ config
, lib
, inputs
, pkgs
, ...
}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        eglot
        elfeed-tube
        elfeed-tube-mpv
        emacsql
        emacsql-sqlite
        ob-http
        vterm
      ];
    package = pkgs.emacs29;
  };

  home = {
    packages = with pkgs; [
      emacs-all-the-icons-fonts
    ];

    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
  };

  xdg.configFile.doom = {
    source = ../../../../config/doom;
    recursive = true;
  };

  home.activation.installDoomEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.xdg.configHome}/emacs" ]; then
       ${pkgs.git}/bin/git clone -n "https://github.com/doomemacs/doomemacs" "${config.xdg.configHome}/emacs"
    fi
    ${pkgs.git}/bin/git -C "${config.xdg.configHome}/emacs" fetch || exit 0
    ${pkgs.git}/bin/git -C "${config.xdg.configHome}/emacs" checkout -f ${inputs.doomemacs.rev}
  '';
}
