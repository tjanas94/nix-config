{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

    neovim-flake.url = "github:neovim/neovim?dir=contrib";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";

    filetype-nvim.url = "github:nathom/filetype.nvim";
    filetype-nvim.flake = false;

    polyword-vim.url = "github:bendk/polyword.vim";
    polyword-vim.flake = false;

    tmux-gruvbox-truecolor.url = "github:lawabidingcactus/tmux-gruvbox-truecolor";
    tmux-gruvbox-truecolor.flake = false;

    wallpapers = {
      type = "git";
      url = "https://gitlab.com/dwt1/wallpapers.git";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    neovim-flake,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    overlays = {
      default = import ./overlay {inherit inputs;};
      neovim = neovim-flake.overlay;
      nixgl = nixgl.overlay;
    };

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    devShells = forAllSystems (system: {
      default = nixpkgs.legacyPackages.${system}.callPackage ./shell.nix {};
    });

    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    legacyPackages = forAllSystems (system:
      import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues overlays;
        config.allowUnfree = true;
      });

    packages.x86_64-linux.nixos-iso =
      nixosConfigurations.nixos-iso.config.system.build.isoImage;

    nixosConfigurations = {
      dell = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = {inherit inputs;};
        modules = (builtins.attrValues nixosModules) ++ [./hosts/dell];
      };
      nixos-iso = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = {inherit inputs;};
        modules = (builtins.attrValues nixosModules) ++ [./hosts/nixos-iso];
      };
      nixos-vm = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = {inherit inputs;};
        modules = (builtins.attrValues nixosModules) ++ [./hosts/nixos-vm];
      };
      x230t = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = {inherit inputs;};
        modules = (builtins.attrValues nixosModules) ++ [./hosts/x230t];
      };
    };

    homeConfigurations = {
      "tjanas@dell" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules =
          (builtins.attrValues homeManagerModules)
          ++ [./home/tjanas];
      };
      "tjanas@lenovo" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules =
          (builtins.attrValues homeManagerModules)
          ++ [./home/tjanas/linux.nix];
      };
      "tjanas@nixos-vm" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules =
          (builtins.attrValues homeManagerModules)
          ++ [./home/tjanas];
      };
      "tjanas@x230t" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules =
          (builtins.attrValues homeManagerModules)
          ++ [./home/tjanas];
      };
    };
  };
}
