{inputs}: {
  additions = pkgs: _: import ../pkgs {inherit pkgs;};

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages {};
    tmuxPlugins = prev.tmuxPlugins // final.callPackage ../pkgs/tmux-plugins {inherit inputs;};
    vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {inherit inputs;};
  };

  neovim = inputs.neovim-flake.overlay;
}
