{
  services.xserver.displayManager = {
    lightdm.enable = true;
    defaultSession = "xsession";
    session = [
      {
        manage = "desktop";
        name = "xsession";
        start = "exec $HOME/.xsession";
      }
    ];
  };
}
