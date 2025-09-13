{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.default];

  environment.persistence."/persist" = {
    hideMounts = true;
    files = [
      "/etc/machineid"
      # "/etc/ssh/ssh_host_ed25519_key"
    ];
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/"
    ];
  };

  programs.fuse.userAllowOther = true;

  security.sudo.extraConfig = ''Defaults lecture="never"'';

  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume for impermanence";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@cryptroot.service"];
    before = ["sysroot.mount"];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /mnt
      mount -t btrfs /dev/mapper/cryptroot /mnt

      # Recursively delete all nested subvolumes inside /mnt/root
      btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
        echo "Deleting /$subvolume subvolume..." >> /mnt/rollback.log
        btrfs subvolume delete "/mnt/$subvolume"
      done

      echo "Deleting /root subvolume..." >> /mnt/rollback.log
      btrfs subvolume delete /mnt/root

      echo "Restoring blank /root subvolume..." >> /mnt/rollback.log
      btrfs subvolume snapshot /mnt/root-blank /mnt/root

      umount /mnt
    '';
  };

  system.activationScripts.persistent-dirs.text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /persist${user.home}
        chown ${user.name}:${user.group} /persist${user.home}
      '';
    # TODO make this only work when user will have home directory
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);
}
