{ pkgs, ... }:
{
  imports = [
    ../wayland
  ];

  xdg.portal.wlr.enable = true;
  
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = pkgs.sway-displaylink;
    extraOptions = ["--unsupported-gpu"];
  };

  environment.systemPackages = with pkgs; [
    swaybg
  ];

  home-manager.users.janle = {
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
        "sway/config".source = ./sway/config;
        "sway/scripts" = {
          source = ./sway/scripts;
          recursive = true;
        };
      };
    };
}
