{config, lib, pkgs, ...}:
let
  path = "/etc/nixos";
  app = "/run/current-system/sw/bin";
in
{
  # Fix dir perms
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
}
