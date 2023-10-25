{ outputs, ... }: {
  imports =
    [
      ./cli/aliases.nix
      ./cli/git.nix
      ./cli/gpg.nix
      ./cli/plugins.nix
      ./cli/readline.nix
      ./cli/ssh.nix
      ./cli/tmux.nix
      ./cli/zsh.nix
      ./home.nix
      ./nix.nix
      ./programs/cli.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);
}
