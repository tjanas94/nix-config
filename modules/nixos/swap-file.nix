{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.swapFile;
in {
  options.swapFile = {
    enable = mkEnableOption "swap file";

    path = mkOption {
      type = types.str;
      example = "/swapfile";
    };

    size = mkOption {
      type = types.int;
      example = 8 * 1024;
    };
  };

  config = mkIf cfg.enable {
    swapDevices = [
      {
        device = cfg.path;
        inherit (cfg) size;
      }
    ];
  };
}
