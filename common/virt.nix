{ pkgs, ... }:
{
  # QEMU-KVM
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager virtiofsd ];
  boot.extraModprobeConfig = ''
    options kvm_amd nested=1
    options kvm ignore_msrs=1 report_ignored_msrs=0
  '';

  # virtualbox
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    package = pkgs.unstable.virtualbox;
  };
  users.extraGroups.vboxusers.members = [ "janle" ];
}
