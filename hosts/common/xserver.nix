{ lib, pkgs, ... }: {
  sound.enable = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  programs = {
    dconf.enable = true;
    steam.enable = true;
    wireshark.enable = true;
  };

  services = {
    blueman.enable = true;
    gvfs.enable = true;
    redshift.enable = true;

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
      xkbOptions =
        "caps:ctrl_modifier,shift:both_capslock,terminate:ctrl_alt_bksp";

      displayManager = {
        lightdm.enable = true;
        defaultSession = "xsession";
        session = [{
          manage = "desktop";
          name = "xsession";
          start = "exec $HOME/.xsession";
        }];
      };
    };
  };

  environment.persistence."/persist" = {
    directories = [ "/var/lib/alsa" "/var/lib/bluetooth" ];
  };
}
