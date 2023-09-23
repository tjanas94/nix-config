{
  description = "Your new nix config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    nix-index-database.url = "github:mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    wallpapers.url = "git+https://gitlab.com/dwt1/wallpapers.git";
    wallpapers.flake = false;

    doomemacs.url = "github:doomemacs/doomemacs";
    doomemacs.flake = false;
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
    in
    rec {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays =
        import ./overlays { inherit inputs; };

      packages =
        forAllSystems
          (
            system:
            import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; }
          )
        // {
          x86_64-linux.installer = nixosConfigurations.installer.config.system.build.isoImage;
        };

      devShells = forAllSystems (
        system:
        import ./shell.nix { pkgs = nixpkgs.legacyPackages.${system}; }
      );

      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        });

      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/dell ];
        };
        installer = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/installer ];
        };
        lenovo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/lenovo ];
        };
        nixos-vm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixos-vm ];
        };
        x230t = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/x230t ];
        };
      };
    };
}
