{
  services.xserver.displayManager = {
    lightdm.enable = true;
    session = [
      {
        manage = "desktop";
        name = "xsession";
        start = "exec $HOME/.xsession";
      }
    ];
  };
  services.displayManager.defaultSession = "xsession";
}
