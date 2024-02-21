# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{

  nixpkgs.config = { allowUnfree = true; };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
  ];

  services.xserver.excludePackages = with pkgs; [ xterm ];

  environment.systemPackages = with pkgs; [
    wget
    firefox
    konsole
    mpv
    xsettingsd
    neofetch
    htop
    git
    gimp
    discover
    vscode
    nixfmt
  ];

  services.flatpak.enable = true;
  programs.dconf.enable = true;

  services.flatpak.packages = [
    "com.spotify.Client"
    "net.lutris.Lutris"
    "com.discordapp.Discord"
    "com.valvesoftware.Steam"
  ];

  # Fix cursors, fonts and icons in flatpak applications

  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs;
        [
          libsForQt5.breeze-qt5 # for plasma
          #gnome.gnome-themes-extra
        ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };

}

