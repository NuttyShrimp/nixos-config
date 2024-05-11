{ pkgs, inputs, lib, ... }:
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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  hardware.opengl = {
    package = pkgs.unstable.mesa.drivers;
    package32 = pkgs.unstable.pkgsi686Linux.mesa.drivers;
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    xwayland
    wdisplays
    wl-clipboard
    rofi-wayland
    xdg-utils
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    dunst
    unstable.waybar
    unstable.polkit_gnome
    lxappearance
    glib
    # File manager things
    pcmanfm
    shared-mime-info
    lxmenu-data
    xwaylandvideobridge
  ];

  security.pam.services.swaylock = { };
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.gdm.gnupg.enable = true;

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_SIZE = "16";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1.25";
    GDK_DPI_SCALE = "0.75";
  };


  home-manager.users.janle =
    let
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
            command = "${pkgs.swaylock-effects}/bin/swaylock --clock -S --effect-blur 4x4";
          }
          {
            event = "after-resume";
            command = "${pkgs.lib.getBin pkgs.hyprland}/binhyprctl dispatch dpms on";
          }
          {
            event = "lock";
            command = "${pkgs.swaylock-effects}/bin/swaylock --clock -S --effect-blur 4x4";
          }
        ];
        timeouts = [
          {
            timeout = 900;
            command = "${pkgs.swaylock-effects}/bin/swaylock --clock -S --effect-blur 4x4";
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
