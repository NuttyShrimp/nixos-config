{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home.sessionVariables = { EDITOR = "nvim"; };

  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];

  home.packages = with pkgs.unstable; [
    # Utilities
    openssl
    jq
    killall
    htop
    wget
  ];
}
