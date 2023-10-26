{ pkgs, config, ... }:
{
  home-manager.users.janle = {
    home.packages = with pkgs; [
      unstable.dunst
    ];

    xdg.configFile = {
      "dunst/dunstrc".source = ./dunst/dunstrc;
      "dunst/assets" = {
        source = ./dunst/assets;
	recursive = true;
      };
      "dunst/scripts" = {
        source = ./dunst/scripts;
	recursive = true;
      };
    };
  };
}
