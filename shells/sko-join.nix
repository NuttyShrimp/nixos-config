{ pkgs, inputs, ... }: pkgs.devshell.mkShell {
  name = "SKO Join";
  imports = [ "${inputs.devshell}/extra/language/ruby.nix" ];
  env = [
    {
      name = "LD_LIBRARY_PATH";
      eval = "$LD_LIBRARY_PATH:$LD_LIBRARY_PATH/mariadb:${pkgs.stdenv.cc.cc.lib}/lib";
    }
  ];
  packages = with pkgs; [
    nodejs
    postgresql_16
    yarn
  ];
  language.ruby = {
    package = pkgs."ruby-3.2.2";
    nativeDeps = with pkgs; [ libmysqlclient zlib libffi openssl libyaml postgresql_16 ];
  };
}
