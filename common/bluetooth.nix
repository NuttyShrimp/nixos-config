{ config, pkgs, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };
  };
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    bluez
  ];
}
