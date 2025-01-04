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
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    nixd.url = "github:nix-community/nixd";
    nixd.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    wallpapers.url = "git+https://gitlab.com/dwt1/wallpapers.git";
    wallpapers.flake = false;
  };

  outputs =
    { self
    , nixpkgs
    , pre-commit-hooks
    , ...
    } @ inputs:
    let
      inherit (nixpkgs) lib;
      inherit (self) outputs;
      specialArgs = { inherit inputs outputs; };
      systems = [ "x86_64-linux" ];
      legacyPackages = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
        config.allowUnfree = true;
      });
      forAllSystems = f: lib.genAttrs systems (system: f legacyPackages.${system});
    in
    rec {
      inherit lib legacyPackages;
      checks = forAllSystems (pkgs: {
        pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
          src = ./.;
          hooks.nixpkgs-fmt.enable = true;
        };
      });
      devShells = forAllSystems (pkgs: pkgs.callPackage ./shell.nix specialArgs);
      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);
      packages =
        let packages = forAllSystems (pkgs: pkgs.callPackage ./pkgs { });
        in packages // {
          x86_64-linux = packages.x86_64-linux // {
            installer =
              nixosConfigurations.installer.config.system.build.isoImage;
          };
        };

      homeManagerModules = import ./modules/home-manager;
      nixosModules = import ./modules/nixos;
      overlays = import ./overlays specialArgs;

      nixosConfigurations = {
        dell = lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/dell ];
        };
        installer = lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/installer ];
        };
        hp = lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/hp ];
        };
        nixos-vm = lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/nixos-vm ];
        };
        x230t = lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/x230t ];
        };
      };
    };
}
