{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.default];

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../secrets.yaml;
    secrets = {
      user-password.neededForUsers = true;
      user-ssh-key.owner = "laincy";
      git-ssh-key.owner = "laincy";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };

    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
