{
  inputs = {
    # NOTE: Replace "nixos-23.11" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
  outputs = inputs@{ self, nixpkgs, nix-flatpak, ... }: {
    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations.lootbox = nixpkgs.lib.nixosSystem {
      # NOTE: Change this to aarch64-linux if you are on ARM
      system = "x86_64-linux";
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./computers/lootbox.nix
        ./audio.nix
        ./bootloader.nix
        ./configuration.nix
        ./environment.nix
        ./graphics.nix
        ./packages.nix
        ./windowing_system.nix
      ];
    };
  };
}
