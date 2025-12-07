{config, lib, pkgs, ...}:

{
  options = {
    nixgroup.enable =
      lib.mkEnableOption "Enable nix group used for permissions"
  };

  config = {
    # will be done eventually
  };
}
