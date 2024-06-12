{
  description = "Nixos flake configuration";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nuttyshrimp.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nuttyshrimp.cachix.org-1:Bx7Cieoc0RadRxisOW/32HAWB1icAAFNKOxaIBVUzpg="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
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
    nixpkgs-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # hyprwm
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs =
    inputs@{ nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , flake-utils
    , home-manager
    , agenix
    , devshell
    , hyprland
    , nixpkgs-ruby
    , ...
    }:
    let
      # pkgs = nixpkgs.legacyPackages."x86_64-linux";

      overlay = final: prev: {
        unstable = import nixpkgs-unstable {
          system = prev.system;
          inherit nixpkgs;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
        };
      };

      overlays = [
        overlay
        agenix.overlays.default
        devshell.overlays.default
        nixpkgs-ruby.overlays.default
      ];

      mkMachine = extraModules:
        nixpkgs.lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./common
            ({ config, pkgs, ... }: {
              nixpkgs = {
                overlays = [
                  (import ./overlays/visual-paradigm.nix pkgs)
                  (import ./overlays/berkeley_mono.nix pkgs)
                  (self: super: {
                    agenix = agenix.packages.${system}.default;
                  })
                ] ++ overlays;
                config.allowUnfree = true;
              };
            })
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            ({ config, ... }: {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            })
          ] ++ extraModules;
        };

      lsShells = builtins.readDir ./shells;
      shellFiles = builtins.filter (name: lsShells.${name} == "regular") (builtins.attrNames lsShells);
      shellNames = builtins.map (filename: builtins.head (builtins.split "\\." filename)) shellFiles;
      systemAttrs = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import inputs.nixpkgs-unstable {
            inherit overlays system;
            config.allowUnfree = true;

          };
          nameToValue = name: import (./shells + "/${name}.nix") { inherit pkgs inputs system; };
        in
        {
          devShells = builtins.listToAttrs (builtins.map (name: { inherit name; value = nameToValue name; }) shellNames);
        }
      );

    in
    systemAttrs // {
      # devShells.x86_64-linux.default = pkgs.mkShell {
      #   buildInputs = [
      #     agenix.packages.x86_64-linux.agenix
      #   ];
      # };

      nixosConfigurations = {
        G14-nixos = mkMachine [
          ./hosts/G14-nixos/configuration.nix
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.asus-zephyrus-ga401
        ];
      };
    };
}
