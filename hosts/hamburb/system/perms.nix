{config, lib, pkgs, ...}:
let
  path = "/etc/nixos";
in
{
  # Fix dir perms
  systemd.services.set-perms = {
    description = "Make /etc/nixos read+write to nix group";
    after = ["network.target"];
    serviceConfig.ExecStart = ''
      export PATH=/run/current-system/sw/bin/:$PATH
      chmod -R 775 ${path}
      chown -R root:nix ${path}
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Environment = "PATH=/run/current-system/sw/bin/:$PATH";
    };
    wantedBy = ["multi-user.target"];
  };
}
