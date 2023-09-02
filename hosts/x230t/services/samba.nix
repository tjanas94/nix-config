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
      hosts allow = 192.168.88. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';

    shares.public = {
      path = "/data/shares/public";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
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
