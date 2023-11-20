{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/amdgpu.nix
    ../../common/bluetooth.nix
    ../../common/docker.nix
    ../../common/fonts.nix
    ../../common/fwupd.nix
    ../../common/gc.nix
    # ../../common/grub.nix
    ../../common/gpg.nix
    ../../common/mariadb.nix
    ../../common/networkmanager.nix
    ../../common/nvidia.nix
    ../../common/pipewire.nix
    ../../common/systemd-boot.nix
    ../../common/zsh.nix
    ../../common/displaylink.nix
    ../../common/qemu.nix
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
    unstable.jetbrains.ruby-mine
    libreoffice
    krita
    speedcrunch
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

  boot.loader.systemd-boot.extraEntries = {
    "arch.conf" = ''
      title   Arch Linux
      linux   /boot/vmlinuz-linux
      initrd  /boot/amd-ucode.img
      initrd  /boot/initramfs-linux.img
      options root="UUID=df305880-9944-4046-aef8-1f215aed9dc2"
    '';
  };
}
