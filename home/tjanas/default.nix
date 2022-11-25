{ ... }: {
  imports = [ ./common/cli ./common/gui ];

  home = rec {
    username = "tjanas";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };
}
