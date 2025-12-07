{config, lib, pkgs, ...}:
let
  path = "/etc/nixos";
  app = "/run/current-system/sw/bin";
in
{

  options = {
    nixdirperms.enable =
      lib.mkEnableOption "Set /etc/nixos to 755 owned by root:nix";
  };
  # Fix dir perms
  config = lib.mkIf config.nixdirperms.enable {
    systemd.services.set-perms = {
      description = "Make /etc/nixos read+write to nix group";
      after = ["network.target"];
      serviceConfig = {
        ExecStart = ''
          ${app}/chmod -R 775 ${path}
          ${app}/chown -R root:nix ${path}
        '';
        Type = "oneshot";
        RemainAfterExit = true;
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
