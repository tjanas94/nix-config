{
  pkgs,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    extraConfig = ''
      set -g renumber-windows on
      set -g status-left-length '80'
      set -g status-right-length '80'
      set -ga terminal-overrides ',xterm-256color*:Tc'
      set -g set-titles on
      set -g set-titles-string '#S / #W'

      bind r source-file ~/.config/tmux/tmux.conf
      bind f run-shell 'tmux neww switch-project'
      bind C-f run-shell 'clone-tmux-client'
    '';
    historyLimit = 50000;
    keyMode = "vi";
    shortcut = "a";
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
      open
      pain-control
      yank
    ];
  };
}
