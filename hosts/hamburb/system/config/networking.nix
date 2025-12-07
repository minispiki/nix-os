{config, lib, pkgs, ...}:

{
  options = {
    network.enable =
      lib.mkEnableOption "Enable + configure networkmanager";
  };

  config = lib.mkIf config.network.enable {
    networking = {
      networkmanager = {
        enable = true;
      };
    };
  };
}
