{ config, pkgs, ... }:

{
  programs = {
    nm-applet.enable = true;
  };

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  environment.systemPackages = with pkgs.unstable; [
    networkmanagerapplet
  ];
}
