{ pkgs, inputs, ... }: pkgs.devshell.mkShell {
  name = "SKO Join";
  imports = [ "${inputs.devshell}/extra/language/ruby.nix" ];
  env = [
    { name = "DATABASE_HOST"; eval = "$PRJ_DATA_DIR/postgres"; }
    { name = "PGDATA"; eval = "$PRJ_DATA_DIR/postgres"; }
  ];
  commands = [
    {
      name = "pg:setup";
      category = "database";
      help = "Setup postgres in project folder";
      command = ''
        initdb --encoding=UTF8 --no-locale --no-instructions -U postgres
        echo "listen_addresses = ${"'"}${"'"}" >> $PGDATA/postgresql.conf
        echo "unix_socket_directories = '$PGDATA'" >> $PGDATA/postgresql.conf
        echo "CREATE USER postgres WITH PASSWORD 'password' CREATEDB SUPERUSER;" | postgres --single -E postgres
      '';
    }
    {
      name = "pg:start";
      category = "database";
      help = "Start postgres instance";
      command = ''
        [ ! -d $PGDATA ] && pg:setup
        postgres
      '';
    }
    {
      name = "pg:console";
      category = "database";
      help = "Open database console";
      command = ''
        psql --host $PGDATA s
      '';
    }
  ];
  packages = with pkgs; [
    nodejs
    postgresql_16
    yarn
  ];
  language.ruby = {
    package = pkgs."ruby-3.3.4";
    nativeDeps = with pkgs; [ libmysqlclient zlib libffi openssl libyaml postgresql_16 ];
  };
}
