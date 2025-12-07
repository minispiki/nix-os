# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/system.nix
      ./user/user.nix
      inputs.home-manager.nixosModules.default
    ];

  # Fix perms for /etc/nixos
  nixdirperms.enable = true;

  # enable plymouth
  plymouth.enable = true;

  networking.hostName = "hamburb";
  
  users.groups.nix = {
    name = "nix";
    members = [
      "root"
      "minispiki"
    ];
  };

  users.users.minispiki = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # Insert pkgs
    ];
  };

  home-manager = {
    backupFileExtension = ".bak";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "minispiki" = import ./home/minispiki/home.nix;
    };
  };

  
  # Nix pkg man config
  nixpkgs.config = {
    allowUnfree = true; # Allow closed sourced programs
  };

  # nh bc its better
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    # Handle Rubbish
    clean = {
      enable = true;
      extraArgs = "--keep-since 3d --keep 3";
    };
  };


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim 
    curl
    git
    wget
    tmux
  ];

  # Flatpak
  services.flatpak.enable = true;
  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Environment
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  services.displayManager.sddm = {enable = true; wayland.enable = true;};
  services.desktopManager.plasma6.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; 

}

