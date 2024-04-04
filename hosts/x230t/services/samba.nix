{
  services.samba = {
    enable = true;
    openFirewall = true;

    extraConfig = ''
      workgroup = WORKGROUP
      server string = x230t
      netbios name = x230t
      security = user
      #use sendfile = yes
      #max protocol = smb2
      hosts allow = 10.1.10. 10.1.40. 10.1.50. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';

    shares.public = {
      path = "/data/shares/public";
      browseable = "yes";
      writeable = "yes";
      public = "yes";
      "create mask" = "0664";
      "force create mode" = "0664";
      "directory mask" = "2775";
      "force directory mode" = "2775";
      "force user" = "samba";
      "force group" = "samba";
    };
  };

  users = {
    groups.samba = { };
    users.samba = {
      group = "samba";
      isSystemUser = true;
    };
  };
}
