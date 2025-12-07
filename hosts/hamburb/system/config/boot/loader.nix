{config, lib, pkgs, ...}:

{
  options = {
    bootloader.enable = 
      lib.mkEnableOption "Setup bootloader";
  };
  config = lib.mkIf config.nixdirperms.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables= true;
    };
  };
}
