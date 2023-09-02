{ config, ... }: {
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../../../../config/gnupg/public.asc;
        trust = "ultimate";
      }
    ];
    scdaemonSettings = {
      disable-ccid = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      grabKeyboardAndMouse = false;
      defaultCacheTtl = 300;
      defaultCacheTtlSsh = 300;
      maxCacheTtl = 900;
      maxCacheTtlSsh = 900;
      enableSshSupport = true;
      enableExtraSocket = true;
    };
  };

  home.sessionVariablesExtra = ''
    if [[ "$SSH_AUTH_SOCK" != /tmp/* ]]; then
      export SSH_AUTH_SOCK="$(${config.programs.gpg.package}/bin/gpgconf --list-dirs agent-ssh-socket)"
    fi
  '';
}
