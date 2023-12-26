{ config, pkgs, lib, ... }:
let
  lazy-nix-helper-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lazy-nix-helper.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "b-src";
      repo = "lazy-nix-helper.nvim";
      rev = "401f3397ecd3d2acd000b1de5a6041b5fa8be29b";
      hash = "sha256-aoKK1co5/x+jZs5RUyLKdhg4Abq3y8Ry2HetuOq3veI=";
    };
  };
in {
  programs.neovim = {
    enable = true;
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
      lazy-nix-helper-nvim
      lazy-nvim
      {
        plugin = (nvim-treesitter.withAllGrammars);
        type = "lua";
      }
      telescope-fzf-native-nvim
    ];
    extraLuaConfig = ''
        require("vim-config")

        local lazy_nix_helper_path = "${lazy-nix-helper-nvim}"
        if not vim.loop.fs_stat(lazy_nix_helper_path) then
          lazy_nix_helper_path = vim.fn.stdpath("data") .. "/lazy_nix_helper/lazy_nix_helper.nvim"
          if not vim.loop.fs_stat(lazy_nix_helper_path) then
            vim.fn.system({
              "git",
              "clone",
              "--filter=blob:none",
              "https://github.com/b-src/lazy_nix_helper.nvim.git",
              lazy_nix_helper_path,
            })
          end
        end

        -- add the Lazy Nix Helper plugin to the vim runtime
        vim.opt.rtp:prepend(lazy_nix_helper_path)

        -- call the Lazy Nix Helper setup function. pass a default lazypath for non-nix systems as an argument
        local non_nix_lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        local lazy_nix_helper_opts = { lazypath = non_nix_lazypath }
        require("lazy-nix-helper").setup(lazy_nix_helper_opts)

        -- get the lazypath from Lazy Nix Helper
        local lazypath = require("lazy-nix-helper").lazypath()
        if not vim.loop.fs_stat(lazypath) then
          vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
          })
        end
        vim.opt.rtp:prepend(lazypath)
        require("lazy").setup("plugins", {
          config = {
            performance = {
              reset_packpath = false
            }
          }
        })
        require("nutty")
      '';
  };
  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.configFile = {
    "nvim/lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/users/janle/hm/configurations/nvim/lua";
      recursive = true;
    };
  };
}
