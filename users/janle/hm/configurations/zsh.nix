{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      gs = "git status";
      ga = "git add";
      gp = "git push";
      gpf = "git psh --force-with-lease";
      gps = "git stash && git pull --rebase && git stash pop";
      pn = "pnpm";
      tmuxt = "tmux attach -t default || tmux new-session -A -s 0";
    };
    enableAutosuggestions = true;
    initExtraBeforeCompInit = ''
      ${builtins.readFile ./zsh/session_variables.zsh}
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
  programs.starship.enable = true;
}
