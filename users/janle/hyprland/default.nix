{ pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ../../../common/pipewire.nix
  ];

  services.xserver = {
    enable = true;
    displayManager = {
      # Works with hyprland but crashes at first start
      gdm = {
	enable = true;
 	wayland = true;
      };
      startx.enable = false;
    };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    xwayland
    wdisplays
    wl-clipboard
    rofi
    xdg-utils
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    dunst
    waybar
    swaylock
    swaylock-effects
    swayidle
    pcmanfm
    unstable.polkit_gnome
    unstable.asdf-vm
  ];

  security.pam.services.swaylock = {};

  home-manager.users.janle = {
    xdg.configFile = {
      "rofi/config.rasi".source = ./rofi/config.rasi;
      "rofi/colors.rasi".source = ./rofi/colors.rasi;
      "rofi/fonts.rasi".source = ./rofi/fonts.rasi;
    };
  };
}
