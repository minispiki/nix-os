{config, lib, pkgs, ...}:

{

  imports = [
    ./perms.nix
  ];

  boot=  {
    plymouth = {
      enable = true;
      theme= "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "rings"
          ];
        })
      ];
    };
    
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    
    loader = {
      # Systemd boot
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

 
  # Networking
  networking = {
    hostName = "hamburb";
    networkmanager.enable = true;
  };

  # Userborn Authentication
  services.userborn.enable = true;

  systemd.tmpfiles.rules = [
    "d /etc/nixos 0755 0 990 - -" # make nixos files readable and /etc/nixos writable
  ];

  # Timezone
  time.timeZone = "Europe/London";
  
  # Language
  i18n.defaultLocale = "en_GB.UTF-8"; # Im british, so what?
  console = {
    keyMap = lib.mkDefault "us";
    useXkbConfig = true;
  };
  
  #nix.gc = {
  #  automatic = true;
  #  dates = "20:00";
  #  options = "--delete-older-than 3d";
  #};

  system.autoUpgrade.enable = true;
}

