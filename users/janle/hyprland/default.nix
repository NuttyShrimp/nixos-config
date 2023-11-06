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
    unstable.waybar
    swaylock
    swaylock-effects
    swayidle
    pcmanfm
    unstable.polkit_gnome
    gnome3.adwaita-icon-theme
  ];

  security.pam.services.swaylock = { };

  home-manager.users.janle = {
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./alacritty.yml;
      "hypr/hyprland.conf".source = ./hypr/hyprland.conf;
      "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
      "hypr/scripts" = {
        source = ./hypr/scripts;
        recursive = true;
      };
      "rofi" = {
        source = ./rofi;
        recursive = true;
      };
      "waybar" = {
        source = ./waybar;
        recursive = true;
      };
    };
  };
}
