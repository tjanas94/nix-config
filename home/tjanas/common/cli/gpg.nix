{...}: {
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../../../../config/gnupg/public.asc;
        trust = "ultimate";
      }
    ];
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 300;
      defaultCacheTtlSsh = 300;
      maxCacheTtl = 900;
      maxCacheTtlSsh = 900;
      enableSshSupport = true;
      enableExtraSocket = true;
    };
  };
}
