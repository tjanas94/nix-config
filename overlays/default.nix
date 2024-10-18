{ inputs, ... }: {
  additions = pkgs: _: import ../pkgs { inherit pkgs; };

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages { };
    bun = prev.bun.overrideAttrs rec {
      version = "1.1.31";
      src = prev.fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64.zip";
        hash = "sha256-zHitG4Ktt+iCKk9GrC3C4MRSWhUxh89kW9bUeHzqNJs=";
      };
    };
    herbstluftwm = prev.herbstluftwm.overrideAttrs {
      doCheck = false;
    };
  };

  stable-packages = final: _prev: {
    nixpkgs-stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = inputs.emacs-overlay.overlays.default;
  nixd = inputs.nixd.overlays.default;
}
