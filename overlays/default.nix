{inputs}: {
  additions = pkgs: _: import ../pkgs {inherit pkgs;};

  modifications = final: prev: {
    herbstluftwm = prev.herbstluftwm.overrideAttrs (old: {
      doCheck = false;
    });
  };

  stable-packages = final: _prev: {
    nixpkgs-stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  master-packages = final: _prev: {
    nixpkgs-master = import inputs.nixpkgs-master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = inputs.emacs-overlay.overlays.default;
}
