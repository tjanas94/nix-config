{pkgs, ...}: {
  environment.systemPackages = with pkgs; [byobu git gnupg home-manager pinentry-curses tmux vim];
  programs.command-not-found.enable = false;
}
