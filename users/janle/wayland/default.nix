{ pkgs, ... }:
{
  imports = [
    ./dunst.nix
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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland
    wdisplays
    wlr-randr
    wl-clipboard
    rofi-wayland
    xdg-utils
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

  security.pam.services.gdm.gnupg.enable = true;

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_SIZE = "16";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1.25";
    GDK_DPI_SCALE = "0.75";
    XDG_SESSION_TYPE = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };


  home-manager.users.janle = {
    xdg.configFile = {
      "alacritty/alacritty.toml".source = ./alacritty.toml;
      "rofi" = {
        source = ./rofi;
        recursive = true;
      };
      "swappy/config".source = ./swappy.conf;
      "waybar" = {
        source = ./waybar;
        recursive = true;
      };
    };
  };
}
