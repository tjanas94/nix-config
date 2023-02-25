{inputs}: {
  additions = pkgs: _: import ../pkgs {inherit pkgs;};

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages {};
    tmuxPlugins = prev.tmuxPlugins // final.callPackage ../pkgs/tmux-plugins {inherit inputs;};
    vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {inherit inputs;};

    herbstluftwm = prev.herbstluftwm.overrideAttrs (old: {
      doCheck = false;
    });
  };

  stable-packages = final: _prev: {
    nixpkgs-stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  master-packages = final: _prev: {
    nixpkgs-master = import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = inputs.emacs-overlay.overlays.default;
}
