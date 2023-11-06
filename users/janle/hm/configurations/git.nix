{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "NuttyShrimp";
    userEmail = "jan.lecoutere@hotmail.be";
    aliases = {
      l = "log --graph --oneline --decorate --all";
      pulls = "!git stash && git pull --rebase && git stash pop";
    };
    lfs.enable = true;
    extraConfig = {
      pull.rebase = true;
      credential.helper = "store";
    };
  };
}
