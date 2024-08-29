{ pkgs, ... }: pkgs.devshell.mkShell {
  name = "node";
  packages = with pkgs; [ nodejs nodePackages.yarn nodePackages.pnpm cypress ];
}
