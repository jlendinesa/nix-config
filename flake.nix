{
  description = "Jose's Home Manager configuration flake";

  inputs = {
    # Unstable Nixpkgs channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify-nix input
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixGL input
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }@inputs:
    let
      system = "x86_64-linux";

      # Modificamos esto para forzar que pkgs acepte software privativo, la licencia de NVIDIA y nixGL
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
    in {
      homeConfigurations = {
        "jose@jose-LOQ-15ARP9" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./nix-config/hosts/jose-LOQ-15ARP9/parts.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };

        "jose@jose-Aspire-E1-571" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./nix-config/hosts/jose-Aspire-E1-571/parts.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };
        "jose@jose-B450M-DS3H" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./nix-config/hosts/jose-B450M-DS3H/parts.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
