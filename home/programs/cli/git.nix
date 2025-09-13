{...}: {
  programs.git = {
    enable = true;
    userName = "laincy";
    userEmail = "laincy@proton.me";

    signing.signByDefault = true;

    extraConfig = {
      core.sshCommand = "ssh -i /run/secrets/git-ssh-key";
      init.defaultBranch = "main";
      commit.gpgSign = true;

      user.signingkey = "5F2940129008087631B731F65471EBA658D9DD04";
    };
  };
}
