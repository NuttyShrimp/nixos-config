{ config, ... }:
{
  programs.tmux.enable = true;

  xdg.configFile = {
    "tmux/tmux.conf".source = ./tmux/conf;
    "tmux/tmux.conf.local".source = ./tmux/conf.local;
  };
}
