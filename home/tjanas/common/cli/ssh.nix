{ ... }: {
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    includes = [ "config.d/*" ];
    extraConfig = ''
      AddKeysToAgent yes
      IdentitiesOnly yes
      IdentityFile ~/.ssh/id_ed25519_4.pub
      IdentityFile ~/.ssh/id_rsa_3.pub
      IdentityFile ~/.ssh/id_ed25519_2.pub
      IdentityFile ~/.ssh/id_ed25519_1.pub
    '';
  };

  home.file.".ssh" = {
    source = ../../../../config/ssh;
    recursive = true;
  };
}
