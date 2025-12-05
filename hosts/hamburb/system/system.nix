{config, lib, pkgs, ...}:

{
  # Use systemd bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Systemd stuff 
  systemd.tmpfiles.settings."10-nixos-directory" = {
    "/etc/nixos".d = {
      group = "nix";
      mode = "0775";
    };
    "/etc/nixos/*".z = {
      group = "nix";
      mode = "0775";
    };
  };
 
  # Networking
  networking = {
    hostName = "hamburb";
    networkmanager.enable = true;
  };

  # Userborn Authentication
  services.userborn.enable = true;
  
  # Timezone
  time.timeZone = "Europe/London";
  
  # Language
  i18n.defaultLocale = "en_GB.UTF-8"; # Im british, so what?
  console = {
    keyMap = lib.mkDefault "us";
    useXkbConfig = true;
  };
  
  nix.gc = {
    automatic = true;
    dates = "20:00";
    options = "--delete-older-than 3d";
  };

  system.autoUpgrade.enable = true;
}

