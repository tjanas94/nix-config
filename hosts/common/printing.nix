{pkgs, ...}: {
  hardware.sane.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [gutenprint];
    browsing = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All
      BrowseProtocols all
    '';
  };
}
