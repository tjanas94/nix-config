{ pkgs
, inputs
, ...
}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    extraConfig = ''
      set -g detach-on-destroy off
      set -g renumber-windows on
      set -g status-left-length '80'
      set -g status-right-length '80'
      set -ga terminal-overrides ',xterm-256color*:Tc'
      set -g set-titles on
      set -g set-titles-string '#S / #W'

      bind r source-file ~/.config/tmux/tmux.conf
      bind C-s switch-client -l
      bind f neww switch-project
      bind C-f run-shell 'clone-tmux-client'
      bind M-h neww 'vi ~/workspace/projects.txt'
      bind M-a run-shell 'pwd >> ~/workspace/projects.txt'
      bind M-n run-shell 'switch-project "$(sed -n "1{p;q}" ~/workspace/projects.txt)"'
      bind M-e run-shell 'switch-project "$(sed -n "2{p;q}" ~/workspace/projects.txt)"'
      bind M-i run-shell 'switch-project "$(sed -n "3{p;q}" ~/workspace/projects.txt)"'
      bind M-o run-shell 'switch-project "$(sed -n "4{p;q}" ~/workspace/projects.txt)"'
    '';
    historyLimit = 50000;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
      open
      pain-control
      yank
    ];
  };
}
