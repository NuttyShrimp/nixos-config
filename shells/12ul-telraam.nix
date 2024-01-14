{ pkgs, inputs, ... }: pkgs.devshell.mkShell {
  name = "12ul-telraam";
  packages = with pkgs; [
    jetbrains.idea-ultimate
    openjdk17
    gradle
    postgresql
  ];
  commands = [
    {
      name = "pg:setup";
      category = "database";
      help = "Setup postgres in project folder";
      command = ''
        initdb --encoding=UTF8 --no-locale --no-instructions -U postgres
        echo "unix_socket_directories = '$PGDATA'" >> $PGDATA/postgresql.conf
        echo "CREATE USER telraam_user WITH PASSWORD 'iAMs00perSecrEET' CREATEDB SUPERUSER;" | postgres --single -E postgres
        echo "CREATE DATABASE telraam_dev WITH owner 'telraam_user';" | postgres --single -E postgres
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
  ];
  env = [
    {
      name = "JAVA_HOME";
      value = pkgs.openjdk17.home;
    }
    { name = "DATABASE_HOST"; eval = "$PRJ_DATA_DIR/postgres"; }
    { name = "PGDATA"; eval = "$PRJ_DATA_DIR/postgres"; }
  ];
}
