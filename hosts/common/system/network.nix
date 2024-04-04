{
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    tempAddresses = "disabled";
  };

  environment = {
    etc."gai.conf".text = ''
      label  ::1/128       0
      label  ::/0          1
      label  2002::/16     2
      label ::/96          3
      label ::ffff:0:0/96  4
      precedence  ::1/128       50
      precedence  ::/0          40
      precedence  2002::/16     30
      precedence ::/96          20
      precedence ::ffff:0:0/96  100
    '';

    persistence."/persist".directories = [ "/etc/NetworkManager/system-connections" "/var/lib/NetworkManager" ];
  };
}
