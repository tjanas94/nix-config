{ inputs, ... }: {
  additions = pkgs: _: import ../pkgs { inherit pkgs; };

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages { };
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
