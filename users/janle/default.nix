{ config, ... }:
{
  imports = [
    ./ssh.nix
    ./yubikey.nix
  ];
}
