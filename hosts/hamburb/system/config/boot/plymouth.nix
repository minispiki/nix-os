{config, lib, pkgs, ...}:

let
  look = "rings";
in

{
  options = {
    plymouth.enable = 
      lib.mkEnableOption "Enable plymouth";
  };

  config = lib.mkIf config.plymouth.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "${look}";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [
              "${look}"
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
    };
  };
}
