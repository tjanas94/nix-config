{pkgs, ...}: {
  home.packages = with pkgs; [newsboat];

  xdg.configFile.newsboat = {
    source = ../../../../config/newsboat;
    recursive = true;
  };
}
