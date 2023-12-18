{ config, ... }:
{
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
}
