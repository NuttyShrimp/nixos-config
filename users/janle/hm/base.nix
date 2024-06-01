{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.go/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/share/JetBrains/Toolbox/scripts"
  ];

  home.packages = with pkgs.unstable; [
    # Utilities
    openssl
    jq
    killall
    htop
    wget
    fzf
    unzip
    zip
    ncdu
  ];
}
