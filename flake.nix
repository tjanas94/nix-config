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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    impermanence.url = "github:nix-community/impermanence";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixd.url = "github:nix-community/nixd";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    sops-nix.url = "github:mic92/sops-nix";

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
