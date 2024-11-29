{ inputs, ... }: {
  additions = pkgs: _: import ../pkgs { inherit pkgs; };

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages { };
    bun = prev.bun.overrideAttrs rec {
      version = "1.1.38";
      src = prev.fetchurl {
        url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64.zip";
        hash = "sha256-ph2lNX4o1Jd/zNSFH+1i/02j6jOFMAXH3ZPayAvFOTI=";
      };
    };
    herbstluftwm = prev.herbstluftwm.overrideAttrs {
      doCheck = false;
    };
    vimPlugins = prev.vimPlugins // {
      nvim-paredit = final.vimUtils.buildVimPlugin {
        name = "nvim-paredit";
        src = inputs.nvim-paredit;
      };
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
