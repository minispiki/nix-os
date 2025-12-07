{config, lib, pkgs, ...}:

{

  imports = [
    ./config/perms.nix
    ./config/boot/loader.nix
    ./config/boot/plymouth.nix
    ./config/networking.nix
    ./config/localisation.nix
  ];

  bootloader.enable = true;

 
  # Networking
  network.enable = true;
  
  # Configure localisation
  local.enable = true;

  #nix.gc = {
  #  automatic = true;
  #  dates = "20:00";
  #  options = "--delete-older-than 3d";
  #};

  system.autoUpgrade.enable = true;
}

