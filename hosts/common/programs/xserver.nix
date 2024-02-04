{
  services = {
    redshift.enable = true;

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
      xkb.options = "caps:ctrl_modifier,shift:both_capslock,terminate:ctrl_alt_bksp";
    };
  };
}
