{ pkgs, inputs, lib, ... }:
{
  imports = [
    ./dunst.nix
    ../wayland
  ];

  xdg.portal.wlr.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland-displaylink;
    portalPackage = pkgs.xdg-desktop-portal-hyprland-displaylink;
    # plugins = [
    #   inputs.hyprtracker.packages.${pkgs.system}.hyprtracker
    # ];
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  security.pam.services.swaylock = { };

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
        "hypr/hyprland.conf".source = ./hypr/hyprland.conf;
        "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
        "hypr/scripts" = {
          source = ./hypr/scripts;
          recursive = true;
        };
      };
    };
}
