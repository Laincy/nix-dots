## Installation

```sh
echo <luks password> > /tmp/secret.key

sudo disko-install --flake .#<config> --disk main /dev/<disk> --extra-files <ssh key path> /persist/etc/ssh/ssh_host_ed25519_key
```
