{config, lib, pkgs, ...}
let
  path = "/etc/nixos";
in
{
  # Fix dir perms
  systemd.services.set-perms = {
    description = "Make /etc/nixos read+write to nix group";
    after = ["network.target"];
    serviceConfig.ExecStart = ''
      chmod -R 775 ${path}
      chown -R root:nix ${path}
    '';
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
    wantedBy = ["multi-user.target"]
  };
}
