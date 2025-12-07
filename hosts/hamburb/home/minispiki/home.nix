# I tried
{config, lib, pkgs, inputs, ...}:

{
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  home.username = "minispiki";
  home.homeDirectory = "/home/minispiki";

  home.stateVersion= "25.05"; # Follow nix

  home.packages = with pkgs; [
    btop
    nushell
    fastfetch
    pavucontrol
    gh
    anki-bin
  ];

  programs.bash.enable = true;

  programs = {
    fish = {
      enable = true;
    };

    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
    };
  
    firefox = {
      enable = true;
      profiles.default = {
        extensions.packages = with inputs.firefox-addons.packages.x86_64-linux; [
          ublock-origin
          proton-pass
        ];
      };
    };
    
    git = {
      enable = true;
      settings = {
        user = {
          email = "140969853+minispiki@users.noreply.github.com";
          name = "minispiki";
          signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub"; # Create the ssh key, if non existant, comment this line out
        };
        
        gpg.format = "ssh";
        commit.gpgsign = true;
       
        safe.directory = "/etc/nixos";
      };
    };
  };

  # Flatpak
  services.flatpak.update.auto.enable = true;
  services.flatpak.packages = [
   "org.vinegarhq.Sober"
  ]; 
}  
