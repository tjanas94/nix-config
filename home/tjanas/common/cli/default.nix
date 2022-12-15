{...}: {
  imports = [
    ./aliases.nix
    ./fish.nix
    ./fzf-fish.nix
    ./git.nix
    ./gpg.nix
    ./neovim.nix
    ./newsboat.nix
    ./programs.nix
    ./readline.nix
    ./scripts.nix
    ./ssh.nix
    ./tmux.nix
  ];

  programs = {
    bash.enable = true;
    home-manager.enable = true;
  };

  xdg.enable = true;
  systemd.user.startServices = "sd-switch";
}
