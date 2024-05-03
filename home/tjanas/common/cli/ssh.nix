{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    addKeysToAgent = "yes";
    controlMaster = "auto";
    controlPersist = "60s";
    controlPath = "~/.ssh/sockets.d/%r@%n:%p";
    includes = [ "config.d/*" ];
  };

  home.file.".ssh" = {
    source = ../../../../config/ssh;
    recursive = true;
  };
}
