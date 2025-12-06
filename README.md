# nixos config
simple kde system that works :D

# Notable Issues
```system.nix``` fails to set perms, you must do so in the dirty way:
```sh
sudo chmod -R 775 /etc/nixos
sudo chown -R root:nix /etc/nixos
```
