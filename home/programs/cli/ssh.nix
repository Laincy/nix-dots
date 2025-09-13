{config, ...}: {
  home.persistence."/persist${config.home.homeDirectory}".directories = [".ssh/known_hosts.d"];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*".userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
    extraConfig = "identityFile /run/secrets/user-ssh-key";
  };
}
