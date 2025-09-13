{
  config,
  inputs,
  pkgs,
  self,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [inputs.home-manager.nixosModules.default];

  users.users.laincy = {
    isNormalUser = true;

    extraGroups = ifTheyExist [
      "wheel"
      "networkmanager"
      "podman"
      "libvirtd"
    ];

    shell = config.programs.fish.package;
    hashedPasswordFile = config.sops.secrets.user-password.path;
    openssh.authorizedKeys.keyFiles = [../../home/ssh.pub];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  programs.fish.enable = true;

  home-manager.users.laincy = import ../../home;
  home-manager.extraSpecialArgs = {inherit inputs self;};
}
