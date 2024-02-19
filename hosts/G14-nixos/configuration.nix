{ pkgs, ... }:

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
    ../../common/virt.nix
    ../../users
    ../../users/janle
    ../../users/janle/desktop.nix
    ../../users/janle/hyprland
    ../../users/janle/yubikey.nix
  ];

  environment.systemPackages = with pkgs; [
    notion
    nextcloud-client
    unstable.jetbrains.datagrip
    libreoffice
    krita
    speedcrunch
    unstable.borgbackup
    powertop
    unstable.rust-analyzer
    ungoogled-chromium
    prusa-slicer
    cachix
    glib
    vlc
    libvlc
    obs-studio
    btrfs-progs
    unstable.jetbrains.clion
    unstable.teams-for-linux
  ];

  programs.direnv.enable = true;

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

  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplipWithPlugin ];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8081 ];
    allowedUDPPorts = [ 8081 ];
  };

  boot.loader.systemd-boot.extraEntries = {
    "arch.conf" = ''
      title   Arch Linux
      linux   /vmlinuz-linux
      initrd  /initramfs-linux.img
      options root=UUID=5c9baa43-50d1-424b-80fe-9b07c955ddcf rw nvidia-drm.modeset=1
    '';
    "arch-fallback.conf" = ''
      title   Arch Linux (fallback initramfs)
      linux   /vmlinuz-linux
      initrd  /initramfs-linux-fallback.img
      options root=UUID=5c9baa43-50d1-424b-80fe-9b07c955ddcf rw nvidia-drm.modeset=1
    '';
  };
}
