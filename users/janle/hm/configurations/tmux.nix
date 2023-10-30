{ config, ... }:
{
  programs.tmux.enable = true;
  home.file = {
    ".tmux.conf".source = ./tmux/conf;
    ".tmux.conf.local".source = ./tmux/conf.local;
  };
}
