# Environment variables

{ config, lib, pkgs, ... }:

{

  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "2";
  };
  

}

