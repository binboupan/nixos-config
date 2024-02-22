# Home configuration

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../hardware-configuration.nix
  ];

  networking.hostName = "peruna"; # Define your hostname.
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


# Work computer extra packages
  environment.systemPackages = with pkgs; [
    libreoffice-qt
  ];

nix.settings.experimental-features = [ "nix-command" "flakes" ];
system.stateVersion = "23.11"; # Did you read the comment?

}

