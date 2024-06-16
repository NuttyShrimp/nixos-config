{ config, lib, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  boot.initrd.kernelModules = [ "evdi" ];
  # services.xserver.displayManager.sessionCommands = ''
  #   ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  # '';
}
