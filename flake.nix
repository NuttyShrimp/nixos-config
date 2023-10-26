{
  description = "Nixos flake configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
  };

  outputs = inputs@{
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    home-manager-unstable,
    agenix,
    devshell,
    ...
  }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";

    overlay = final: prev: {
      nix = final.nixVersions.nix_2_16;
      unstable = import nixpkgs-unstable {
        system = prev.system;
        inherit nixpkgs;
        config.allowUnfree = true;
      };
    };


    mkMachine = extraModules:
      nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ({config, ...}: {
            nixpkgs.config.allowUnfree = true;
	    nixpkgs.overlays = [
              overlay
            ];
          })
          agenix.nixosModules.age
          home-manager.nixosModules.home-manager ({config, ...}: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          })
          ./common
        ] ++ extraModules;
      };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        agenix.packages.x86_64-linux.agenix
      ];
    };
    nixosConfigurations = {
      G14-nixos = mkMachine [
    	./hosts/G14-nixos/configuration.nix
	nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.asus-zephyrus-ga401
      ];
    };
  };
}
