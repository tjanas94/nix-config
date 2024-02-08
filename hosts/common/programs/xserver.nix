{
  services = {
    redshift.enable = true;

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
