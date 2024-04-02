{ pkgs, ... }:
{
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;

  home-manager.users.janle = {
    imports = [
      ./hm/configurations/git.nix
      ./hm/configurations/go.nix
      ./hm/configurations/gtk.nix
      ./hm/configurations/nvim.nix
      ./hm/configurations/tmux.nix
      ./hm/configurations/zsh.nix
    ];

    home.packages = with pkgs; [
      ripgrep
      file
      # comms
      slack
      discord
      thunderbird
      # browser
      firefox
      # Utilities
      ansible
      evince
      unstable.spotify
      unstable.vscode
      alacritty
      pavucontrol
      lazygit
      tmux
      qimgv
      slurp
      shotman
    ];
  };
}
