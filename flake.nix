{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:/Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forEachSystem = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  in {
    packages = forEachSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in (import ./pkgs {inherit pkgs inputs;})
    );

    nixosConfigurations = let
      inherit (nixpkgs.lib) nixosSystem;
    in {
      verum = nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs self;};

        modules = [./nixos/verum];
      };

      axiom = nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs self;};

        modules = [./nixos/axiom];
      };

      installer = nixosSystem {
        specialArgs = {inherit inputs self;};
        modules = [
          ./installer.nix
        ];
      };
    };
  };
}
