{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
  ];

  programs = {
    bat.enable = true;
    jq.enable = true;
    tealdeer.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
    fastfetch.enable = true;
  };

  home.packages = with pkgs; [
    glow
    tree
    nurl
  ];
}
