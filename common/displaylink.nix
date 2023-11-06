{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  boot.kernelModules = [ "evdi" ];

  environment.systemPackages = with pkgs; [
    displaylink
  ];
}
