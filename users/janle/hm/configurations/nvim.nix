{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      telescope-fzf-native-nvim
    ];
  };
  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.configFile = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/users/janle/hm/configurations/nvim";
      recursive = true;
    };
  };
}
