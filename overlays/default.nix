{inputs}: {
  additions = pkgs: _: import ../pkgs {inherit pkgs;};

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages {};
    tmuxPlugins = prev.tmuxPlugins // final.callPackage ../pkgs/tmux-plugins {inherit inputs;};
    vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {inherit inputs;};

    herbstluftwm = prev.herbstluftwm.overrideAttrs (old: {
      doCheck = false;
    });

    qutebrowser-qt6 = prev.qutebrowser-qt6.overrideAttrs (old: {
      name = "qutebrowser-git";
      src = inputs.qutebrowser;
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
