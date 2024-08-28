{ config, pkgs, lib, ... }:
let
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  };
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      tree-sitter
      fzf
      fd
      unzip
      nodejs
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      telescope-fzf-native-nvim
    ];
  };
  home.sessionVariables = { EDITOR = "nvim"; };

  home.file."./.config/nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };

  home.file."./.config/nvim/init.lua" = {
    source = ./nvim/init.lua;
  };

  home.file."./.config/nvim/lazy-lock.json" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/janle/dotfiles/users/janle/hm/configurations/nvim/lazy-lock.json;
  };

  home.file."./.config/nvim/lua/nix-config/init.lua".text = ''
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  };
}
