{ pkgs, lib, ... }:
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
    unstable.polkit_gnome
    lxappearance
    # File manager things
    pcmanfm
    shared-mime-info
    lxmenu-data
  ];

  security.pam.services.swaylock = { };

  home-manager.users.janle = let
  in {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };

    services.swayidle = {
      enable = true;
      systemdTarget = "graphical-session.target";
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.lib.getExe pkgs.swaylock-effects} -df";
        }
        {
          event = "after-resume";
          command = "${pkgs.lib.getBin pkgs.hyprland}/binhyprctl dispatch dpms on";
        }
        {
          event = "lock";
          command = "${pkgs.lib.getExe pkgs.swaylock-effects} -df";
        }
      ];
      timeouts = [
        {
          timeout = 900;
          command = "${pkgs.lib.getExe pkgs.swaylock-effects} -df";
        }
        {
          timeout = 1200;
          command = "${pkgs.lib.getBin pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        }
      ];
    };

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
