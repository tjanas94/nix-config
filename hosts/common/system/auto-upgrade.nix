{ inputs
, ...
}: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--recreate-lock-file"
      "--no-write-lock-file"
      "-L"
    ];
    dates = "03:00";
  };
}
