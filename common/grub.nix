{ config, libs, ... }:

{
  boot.loader = {
    grub = {
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };
}
