{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "config.d/*" ];
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      compression = false;
      controlMaster = "auto";
      controlPath = "~/.ssh/sockets.d/%r@%n:%p";
      controlPersist = "60s";
      forwardAgent = false;
      hashKnownHosts = true;
      serverAliveCountMax = 3;
      serverAliveInterval = 0;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };

  home.file.".ssh" = {
    source = ../../../../config/ssh;
    recursive = true;
  };
}
