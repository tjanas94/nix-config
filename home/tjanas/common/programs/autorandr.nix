{
  programs.autorandr.enable = true;

  xdg.configFile.autorandr = {
    source = ../../../../config/autorandr;
    recursive = true;
  };
}
