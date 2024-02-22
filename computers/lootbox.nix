# Home configuration

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../hardware-configuration.nix
  ];

  networking.hostName = "lootbox"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.binboupan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

hardware.logitech.wireless.enable = true;
hardware.logitech.wireless.enableGraphical = true; # for solaar to be included
hardware.bluetooth.enable = true; # enables support for Bluetooth
hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


# Home computer flatpaks
  services.flatpak.packages = [
    "com.spotify.Client"
    "net.lutris.Lutris"
    "com.discordapp.Discord"
    "com.valvesoftware.Steam"
    "net.rpcs3.RPCS3"
    "app.xemu.xemu"
    "net.pcsx2.PCSX2"
    "org.yuzu_emu.yuzu"
    "org.duckstation.DuckStation"
    "net.davidotek.pupgui2"

  ];

# Home computer extra packages
  environment.systemPackages = with pkgs; [
    mpv
    audacious
    audacious-plugins
    qbittorrent
    solaar
  ];



  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };


services.xserver.displayManager.autoLogin.enable = true;
services.xserver.displayManager.autoLogin.user = "binboupan";

nix.settings.experimental-features = [ "nix-command" "flakes" ];
system.stateVersion = "23.11"; # Did you read the comment?

}

