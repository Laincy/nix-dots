{
  config,
  inputs,
  pkgs,
  self,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.default
    ./programs/cli
  ];

  home = {
    username = "laincy";
    homeDirectory = "/home/${config.home.username}";

    stateVersion = "25.11";

    persistence."/persist${config.home.homeDirectory}" = {
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Programming"
      ];

      files = [".local/share/fish/fish_history"];

      allowOther = true;
    };

    packages = [(self.packages.${pkgs.system}.laincy-nvim)];

    sessionVariables.EDITOR = "nvim";
  };
}
