{
  lib,
  inputs,
  pkgs,
  ...
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

  home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
       ${pkgs.git}/bin/git clone -n "https://github.com/doomemacs/doomemacs" "$XDG_CONFIG_HOME/emacs"
    fi
    ${pkgs.git}/bin/git -C "$XDG_CONFIG_HOME/emacs" fetch
    ${pkgs.git}/bin/git -C "$XDG_CONFIG_HOME/emacs" checkout -f ${inputs.doomemacs.rev}
  '';
}
