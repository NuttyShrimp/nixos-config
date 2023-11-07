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
    ../../common/zsh.nix
    ../../common/displaylink.nix
    ../../users
    ../../users/janle
    ../../users/janle/desktop.nix
    ../../users/janle/hyprland
    ../../users/janle/yubikey.nix
  ];

  environment.systemPackages = with pkgs; [
    notion
    rustup
    nextcloud-client
    unstable.jetbrains.datagrip
    libreoffice
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
