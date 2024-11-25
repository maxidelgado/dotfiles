{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, lib, config, ... }: {
      # List packages installed in system profile.
      environment.systemPackages =
        [
          pkgs.vim
          pkgs.direnv
          pkgs.sshs
          pkgs.glow
        ];
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;  # default shell on Catalina
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";
      security.pam.enableSudoTouchIdAuth = true;

      users.users = {
        # Set user's home dynamically based on the environment variable $USER.
        ${lib.mkIf (config.home.username != null) config.home.username} = {
          isNormalUser = true;
          home = "/Users/${config.home.username}";
        };
      };

      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "devops-toolbox";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
      };

      homebrew.enable = true;
      homebrew.casks = [
        "google-chrome"
        "wezterm"
      ];
      homebrew.brews = [
        "imagemagick"
      ];
    };
  in
  {
    darwinConfigurations."generic-darwin-system" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users = {
            # Import the home configuration and set home username dynamically.
            ${toString (config.home.username or "default")} = import ./home.nix;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."generic-darwin-system".pkgs;
  };
}
