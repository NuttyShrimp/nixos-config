let
  g14-janle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGhg7F1y22LxKb1XHakXI5q8EqVoemXMlQFGc4bORXUU";
  g14-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3LzxfQji/O2HnIqS/q5LQkHXEPuCumIHL7YIXh+kqt";
  users = [ g14-janle g14-root ];
in
{
  "hosts/G14-nixos/secrets/borg-pass.age".publicKeys = users;
  "secrets/nas-user.age".publicKeys = users;
  "secrets/nas-pw.age".publicKeys = users;
  "secrets/nas-ip.age".publicKeys = users;
}
