{pkgs, ...}: {
  environment.systemPackages = with pkgs; [byobu git gnupg pinentry-curses tmux vim];
  programs.command-not-found.enable = false;
}
