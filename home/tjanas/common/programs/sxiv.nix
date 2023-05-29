{pkgs, ...}: {
  home.packages = with pkgs; [sxiv];

  xdg.configFile.sxiv = {
    source = ../../../../config/sxiv;
    recursive = true;
  };
}
