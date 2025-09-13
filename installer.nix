{
  pkgs,
  self,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
  ];

  environment.systemPackages = with pkgs; [
    self.packages.${system}.default

    git
    sbctl
    sops
    bitwarden-cli
    nurl
    disko
    parted
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  services.spice-vdagentd.enable = true;

  # Use faster squashfs compression
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
