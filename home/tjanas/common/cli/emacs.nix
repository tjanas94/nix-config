{pkgs, ...}: {
  programs = {
    emacs = {
      enable = true;
      extraPackages = epkgs: [epkgs.vterm];
    };

    bash.initExtra = ''
      if [[ -n "$INSIDE_EMACS" && $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z "$BASH_EXECUTION_STRING" ]]; then
        exec fish
      fi
    '';
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    socketActivation.enable = true;
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
