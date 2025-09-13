{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/laincy.nix
    ../common/optional/plymouth.nix
  ];

  networking = {
    hostName = "axiom";
    networkmanager.enable = true;
  };

  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = true;
    spice-vdagentd.enable = true;

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

  disko.devices.disk.main.device = "/dev/vda";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
