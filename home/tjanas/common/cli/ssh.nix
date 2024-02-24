{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    addKeysToAgent = "yes";
    controlMaster = "auto";
    controlPersist = "60s";
    includes = [ "config.d/*" ];
    extraConfig = ''
      IdentitiesOnly yes
      IdentityFile ~/.ssh/id_ed25519_5.pub
      IdentityFile ~/.ssh/id_ed25519_4.pub
      IdentityFile ~/.ssh/id_rsa_3.pub
      IdentityFile ~/.ssh/id_ed25519_2.pub
      IdentityFile ~/.ssh/id_ed25519_1.pub
    '';
    matchBlocks."github github.com" = {
      hostname = "github.com";
      user = "git";
    };
  };

  home.file.".ssh" = {
    source = ../../../../config/ssh;
    recursive = true;
  };
}
