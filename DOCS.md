Some processes purely for my self because I forget these easily if i'm not using this frequently

## Changing to a different channel
```
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos
sudo nix-channel --update
nix-channel --add https://channels.nixos.org/nixos-unstable nixos
nix-channel --update
```
- change the url in `flake.nix`
- add `--upgrade` to the rebuild command
