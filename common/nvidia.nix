{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    # "nvidia-drm.modeset=1"
    modesetting.enable = true;
    powerManagement = {
      # "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      enable = true;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true;
    # This should be optional but just to be sure
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
