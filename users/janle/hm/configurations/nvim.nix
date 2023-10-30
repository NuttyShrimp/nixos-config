{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      tree-sitter
      fzf
      fd
      unzip
    ];
    plugins = with pkgs.vimPlugins; [
      {
        plugin = (nvim-treesitter.withAllGrammars);
        type = "lua";
      }
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
