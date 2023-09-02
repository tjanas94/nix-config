{ lib, ... }: {
  swapFile = {
    enable = lib.mkDefault true;
    path = "/swap/swapfile";
    size = lib.mkDefault (8 * 1024);
  };

  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };
}
