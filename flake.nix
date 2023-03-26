{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    qutebrowser.url = "github:qutebrowser/qutebrowser";
    qutebrowser.flake = false;

    polyword-vim.url = "github:bendk/polyword.vim";
    polyword-vim.flake = false;

    tmux-gruvbox-truecolor.url = "github:lawabidingcactus/tmux-gruvbox-truecolor";
    tmux-gruvbox-truecolor.flake = false;

    wallpapers.url = "git+https://gitlab.com/dwt1/wallpapers.git";
    wallpapers.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays =
      import ./overlays {inherit inputs;};

    packages =
      forAllSystems (
        system:
          import ./pkgs {pkgs = nixpkgs.legacyPackages.${system};}
      )
      // {
        x86_64-linux.nixos-iso = nixosConfigurations.nixos-iso.config.system.build.isoImage;
      };

    devShells = forAllSystems (
      system:
        import ./shell.nix {pkgs = nixpkgs.legacyPackages.${system};}
    );

    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    legacyPackages = forAllSystems (system:
      import nixpkgs {
        inherit system;
        overlays = builtins.attrValues overlays;
        config.allowUnfree = true;
      });

    nixosConfigurations = {
      dell = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/dell];
      };
      lenovo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/lenovo];
      };
      nixos-iso = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/nixos-iso];
      };
      nixos-vm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/nixos-vm];
      };
      x230t = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/x230t];
      };
    };

    homeConfigurations = {
      "tjanas@dell" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/tjanas];
      };
      "tjanas@lenovo" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/tjanas];
      };
      "tjanas@nixos-vm" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/tjanas];
      };
      "tjanas@x230t" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/tjanas];
      };
    };
  };
}
