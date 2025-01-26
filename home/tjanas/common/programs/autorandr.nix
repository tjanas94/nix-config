{ config, ... }:
{
  programs.autorandr.enable = true;

  xdg.configFile.autorandr.source = config.lib.file.mkOutOfStoreSymlink "/home/tjanas/workspace/github.com/tjanas94/nix-config/master/config/autorandr";
}
