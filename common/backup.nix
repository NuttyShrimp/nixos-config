{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    unstable.borgbackup
  ];

  systemd.services.borg-backup = {
    enable = true;
    description = "Automated backup to NAS";
    wantedBy = [ "multi-user.target" ]; 
    after = [ "network-online.target" ];

    path = with pkgs; [
      unstable.borgbackup
      cifs-utils
    ];

    environment = config.nix.envVars // {
        inherit (config.environment.sessionVariables) NIX_PATH;
        HOME = "/root";
      } // config.networking.proxy.envVars;

    serviceConfig = {
      ExecStart="/home/janle/Documents/scripts/auto-borg-backup.sh";
    };

    startAt = "daily";
  };
  systemd.timers.borg-backup = {
    timerConfig = {
      RandomizedDelaySec = "10min";
      Persistent = true;
    };
  };
}
