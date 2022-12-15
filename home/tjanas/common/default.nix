{...}: {
  imports = [./cli ./gui];

  home = rec {
    username = "tjanas";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };
}
