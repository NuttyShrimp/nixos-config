{ pkgs, ... }: pkgs.devshell.mkShell {
  name = "12ul-count";
  packages = with pkgs; [ nodejs nodePackages.yarn nodePackages.pnpm ];
}
