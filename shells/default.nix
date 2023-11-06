{ pkgs, ... }: pkgs.devshell.mkShell {
  name = "NixOS config";
  commands = [
    {
      name = "format-all";
      category = "general commands";
      help = "Format all nix files in the project";
      command = "find $PRJ_ROOT -type f -name '*.nix' -print0 | xargs -0 nixpkgs-fmt";
    }
    {
      name = "devshell";
      category = "general commands";
      help = "Run nix develop but with the current shell";
      command = "nix develop -c $SHELL $@"
    }
  ];
  packages = [
    pkgs.agenix
    pkgs.nixos-rebuild
    pkgs.nixpkgs-fmt
  ];
}

