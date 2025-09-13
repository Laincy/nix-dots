{pkgs, ...}: let
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "b82982c55582cfaf6f220de1893c7c73dd0cb301";
    hash = "sha256-Dvaw1k7XOU2NUQbTJAXPgAOPN1zTLVrc7NZDY5/KHeM=";
  };
in {
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        set -x GPG_TTY (tty)
      '';
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';

      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
      ];

      shellAbbrs = {
        nrs = "sudo nixos-rebuild switch --flake .";
        nrb = "sudo nixos-rebuild boot --flake .";
        nds = "nix develop -c fish";
      };

      shellAliases = {
        lsa = "ls -a";
        cat = "bat";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };

    carapace = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  xdg.configFile."fish/themes/rose-pine.theme".source = "${rose-pine-fish}/themes/Rosé Pine.theme";

  home.packages = with pkgs; [
    grc
  ];
}
