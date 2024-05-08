{ config, pkgs, ... }:
{
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets = {
    "borg-pass".file = ./secrets/borg-pass.age;
    "nas-user".file = ../../secrets/nas-user.age;
    "nas-pw".file = ../../secrets/nas-pw.age;
    "nas-ip".file = ../../secrets/nas-ip.age;
  };

  services.borgbackup.jobs."truenas" = {
    paths = [
      "/etc"
      "/home"
      "/root"
      "/var"
    ];
    exclude = [
      "/home/*/.cache/*"
      "/var/tmp/*"
    ];
    repo = "/mnt/truenas/backups/g14-nixos";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /run/agenix/borg-pass";
    };
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 6;
    };
    compression = "zstd,9";
    startAt = "20:00";
    persistentTimer = true;
    extraCreateArgs = "--exclude-caches";
    preHook = "${pkgs.mount}/bin/mount -t cifs -o \"username=$(cat /run/agenix/nas-user),password=$(cat /run/agenix/nas-pw)\" $(cat /run/agenix/nas-ip) /mnt/truenas";
    postHook = "${pkgs.umount}/bin/umount /mnt/truenas";
  };
}
