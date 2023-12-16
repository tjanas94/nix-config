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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
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

    nixd.url = "github:nix-community/nixd";
    nixd.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.nixpkgs-stable.follows = "nixpkgs-stable";

    wallpapers.url = "git+https://gitlab.com/dwt1/wallpapers.git";
    wallpapers.flake = false;

    doomemacs.url = "github:doomemacs/doomemacs";
    doomemacs.flake = false;

    harpoon.url = "github:theprimeagen/harpoon";
    harpoon.flake = false;
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
      systems = [ "x86_64-linux" ];
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
        config.allowUnfree = true;
      });
      forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in
    rec {
      inherit lib;
      checks = forAllSystems (pkgs: {
        pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
          src = ./.;
          hooks.nixpkgs-fmt.enable = true;
        };
      });
      devShells = forAllSystems (pkgs: import ./shell.nix { inherit pkgs outputs; });
      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);
      legacyPackages = forAllSystems (pkgs: pkgs);
      packages = forAllSystems (pkgs: import ./pkgs { inherit pkgs; })
        // {
        x86_64-linux.installer =
          nixosConfigurations.installer.config.system.build.isoImage;
      };

      homeManagerModules = import ./modules/home-manager;
      nixosModules = import ./modules/nixos;
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        dell = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/dell ];
        };
        installer = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/installer ];
        };
        hp = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/hp ];
        };
        nixos-vm = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixos-vm ];
        };
        x230t = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/x230t ];
        };
      };
    };
}
