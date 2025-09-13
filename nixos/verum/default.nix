{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/laincy.nix
    ../common/optional/plymouth.nix
  ];

  networking = {
    hostName = "verum";
    networkmanager.enable = true;
  };

  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = true;

    getty.autologinUser = "laincy";
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    sbctl
    sops
    htop
    dust
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
