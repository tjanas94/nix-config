{ inputs, ... }: {
  additions = pkgs: _: import ../pkgs { inherit pkgs; };

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages { };
  };

  stable-packages = final: _prev: {
    nixpkgs-stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = inputs.emacs-overlay.overlays.default;
  nixd = inputs.nixd.overlays.default;
  neovim-nightly = inputs.neovim-nightly-overlay.overlays.default;
}
