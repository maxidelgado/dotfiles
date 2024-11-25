
{ config, pkgs, lib, ... }:

let
  username = builtins.getEnv "USER";
  homeDir = "/Users/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Packages specific to the user.
  home.packages = [
  ];

  # Use a dynamic approach for managing dotfiles based on the home directory.
  home.file = {
    ".zshrc".source = "${homeDir}/dotfiles/zshrc/.zshrc";
    ".config/wezterm".source = "${homeDir}/dotfiles/wezterm";
    ".config/starship".source = "${homeDir}/dotfiles/starship";
    ".config/nvim".source = "${homeDir}/dotfiles/nvim";
    ".config/nix".source = "${homeDir}/dotfiles/nix";
    ".config/nix-darwin".source = "${homeDir}/dotfiles/nix-darwin";
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
