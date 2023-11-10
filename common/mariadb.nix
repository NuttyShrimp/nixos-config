{ pkgs, ... }:
{
  services.mysql.package = pkgs.mariadb;
  services.mysql.enable = true;
}
