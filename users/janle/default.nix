{ config, ... }:
{
  imports = [
    ./gnome-keyring.nix
    ./ssh.nix
    ./yubikey.nix
  ];
}
