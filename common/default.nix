{ config, lib, pkgs, ... }:
{
  boot.tmp.cleanOnBoot = true;
  security.polkit.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

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
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "janle" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.timeZone = lib.mkDefault "Europe/Brussels";
  i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";


  home-manager.users.janle.home.stateVersion = lib.mkDefault "23.05";
  system.stateVersion = lib.mkDefault "23.05";
}
