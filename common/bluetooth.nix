{ config, pkgs, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.unstable.bluez;
    };
    pulseaudio = {
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };
  };
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    unstable.bluez
  ];
}
