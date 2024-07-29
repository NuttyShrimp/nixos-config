{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.zsh.histSize = 100000;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh bash ];
  environment.pathsToLink = [ "/share/zsh" ];
}
