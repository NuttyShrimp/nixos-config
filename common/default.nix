{ config, lib, pkgs, ... }:
{
  boot.tmp.cleanOnBoot = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    light
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      sandbox = true;
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
      trusted-users = [ "root" "janle" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.timeZone = lib.mkDefault "Europe/Brussels";
  i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";


  home-manager.users.janle.home.stateVersion = lib.mkDefault "24.05";
  system = {
    autoUpgrade = {
      enable = true;
      flake = "github:NuttyShrimp/nixos-config";
      dates = "weekly";
      randomizedDelaySec = "10min";
    };
    stateVersion = lib.mkDefault "24.05";
  };
}
