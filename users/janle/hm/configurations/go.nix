{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = ".go";
    package = pkgs.unstable.go;
  };

  home.packages = with pkgs; [
    unstable.golangci-lint
  ];
}
