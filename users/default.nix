{ pkgs, home-manager, ... }:

{
  users.groups.janle.gid = 1000;
  users.users.janle = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "light"
      "networkmanager"
      "docker"
    ];
    group = "janle";
  };

  home-manager.users = {
    janle = (import ./janle/hm/base.nix);
  };
}
