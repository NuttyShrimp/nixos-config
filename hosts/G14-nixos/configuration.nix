{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/amdgpu.nix
    ../../common/bluetooth.nix
    ../../common/fonts.nix
    ../../common/fwupd.nix
    ../../common/grub.nix
    ../../common/gpg.nix
    ../../common/networkmanager.nix
    ../../common/nvidia.nix
    ../../common/pipewire.nix
    ../../users
    ../../users/janle
    ../../users/janle/hyprland
    ../../users/janle/yubikey.nix
  ];

  nixpkgs.config.allowUnfree = true;

  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  networking.hostName = "G14-nixos"; # Define your hostname.

  services.tailscale.enable = true;
}
