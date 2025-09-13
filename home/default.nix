{
  config,
  inputs,
  pkgs,
  self,
  ...
}: {
  imports = [inputs.impermanence.homeManagerModules.default];

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

      allowOther = true;
    };

    packages = with pkgs; [
      (self.packages.${pkgs.system}.laincy-nvim)
      nurl
      neofetch
    ];

    sessionVariables.EDITOR = "nvim";
  };
}
