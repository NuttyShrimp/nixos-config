{ config, pkgs, ... }:
{
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;

  home-manager.users.janle = {
    imports = [
      ./hm/configurations/go.nix
    ];

    home.packages = [
      ripgrep
      # comms
      slack
      discord
      thunderbird
      # browser
      firefox
      # Utilities
      ansible
      evince
      spotify
      vscode
      pavucontrol
    ];
  };
}
