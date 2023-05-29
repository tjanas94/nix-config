{
  programs.dconf.enable = true;

  services = {
    gvfs.enable = true;

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
      xkbOptions = "caps:ctrl_modifier,shift:both_capslock,terminate:ctrl_alt_bksp";
    };
  };
}
