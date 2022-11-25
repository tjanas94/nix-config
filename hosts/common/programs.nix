{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ byobu git home-manager tmux vim ];
  programs.command-not-found.enable = false;
}
