{config, lib, pkgs, ...}:

{
  options = {
    local.enable = 
      lib.mkEnableOption "Setup locale";
  };

  config = lib.mkIf config.local.enable {
    time.timeZone = "Europe/London";
    
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
      keyMap = lib.mkDefault "us";
      useXkbConfig = true;
    };
  };
}
