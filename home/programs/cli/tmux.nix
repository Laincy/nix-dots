{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      rose-pine
    ];

    extraConfig = ''
      set -g default-terminal "alacritty"
      set -ag terminal-features "alacritty:RGB"
    '';
  };
}
