{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = ".go";
    package = pkgs.unstable.go_1_21;
  };

  home.packages = with pkgs; [
    unstable.golangci-lint
  ];
}
