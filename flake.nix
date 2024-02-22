{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs@{ self, nixpkgs, nix-flatpak, ... }: {

    nixosConfigurations.lootbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./computers/lootbox.nix
        ./audio.nix
        ./bootloader.nix
        ./environment.nix
        ./graphics.nix
        ./packages.nix
        ./windowing_system.nix
      ];
    };

    nixosConfigurations.peruna = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./computers/peruna.nix
        ./audio.nix
        ./bootloader.nix
        ./environment.nix
        ./graphics.nix
        ./packages.nix
        ./windowing_system.nix
      ];
    };

  };

  
}
