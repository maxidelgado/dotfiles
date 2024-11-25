# My Nix and Home Manager Configuration

This repository contains my Nix and Home Manager configuration for a Darwin (macOS) system, aimed at providing a reproducible development environment with ease of customization.

## Overview

The repository includes:
- A `flake.nix` file to define system-wide settings, Home Manager integration, and application packages.
- A `home.nix` configuration file to define user-specific settings and packages, making it easy to manage dotfiles and maintain consistency.

The configuration is designed to work with different usernames, allowing easy sharing and reuse across systems without hardcoding user-specific details.

## Requirements

- **Nix**: Nix must be installed on your system. You can follow the instructions at [nixos.org](https://nixos.org/download.html).
- **Nix-Darwin**: This project uses Nix-Darwin to manage system settings on macOS.
- **Home Manager**: Home Manager is used to manage user-specific configurations, including dotfiles.

## Installation

### Step 1: Install Nix

If you don't have Nix installed yet, run the following command to install it:

```sh
curl -L https://nixos.org/nix/install | sh
```

After installation, make sure to enable experimental features for `nix-command` and `flakes` by adding the following to `/etc/nix/nix.conf` or `~/.config/nix/nix.conf`:

```nix
experimental-features = nix-command flakes
```

### Step 2: Install Nix-Darwin

Install Nix-Darwin to manage system settings:

```sh
nix build "github:LnL7/nix-darwin"#darwin-installer && ./result/bin/darwin-installer
```

Once installed, you can use `darwin-rebuild` to apply system changes.

### Step 3: Install Home Manager

Home Manager will help manage your user-specific configurations:

```sh
nix run github:nix-community/home-manager -- switch
```

### Step 4: Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/maxidelgado/dotfiles.git
cd dotfiles
```

### Step 5: Apply the Configuration

Use the following command to apply the Nix-Darwin and Home Manager configuration:

```sh
darwin-rebuild switch --flake ./nix-darwin
```

This will apply both system and user-specific configurations as defined in `flake.nix` and `home.nix`.

## Customization

### Dynamic Username

The configuration is designed to be reusable for any username. The username is detected dynamically from the environment, which makes the setup flexible for use on different machines.

If you need to modify the settings, edit the following files:

- **`flake.nix`**: For system-wide configurations, installed packages, and services.
- **`home.nix`**: For user-specific configurations like dotfiles and additional programs.

### Adding Packages

To add more system-wide packages, edit the `environment.systemPackages` list in `flake.nix`. To add user-specific packages, edit the `home.packages` list in `home.nix`.

### Managing Dotfiles

Dotfiles are managed using `home.file` in `home.nix`. You can point to any file or directory you want to manage. For example, add more configurations like `.vimrc` or `.gitconfig` by editing `home.nix`.

## Updating Dependencies

To update the Nixpkgs version or other inputs, run:

```sh
nix flake update
```

This will regenerate the `flake.lock` file to use the latest versions of dependencies.

## Usage Tips

- **Rebuild the System**: To apply changes, use:
  ```sh
  darwin-rebuild switch --flake .
  ```
- **Home Manager**: To manually apply only Home Manager changes, use:
  ```sh
  home-manager switch --flake .#your-username
  ```

## FAQ

### What is Nix-Darwin?
Nix-Darwin is a tool that brings NixOS-like configurations to macOS, allowing you to manage macOS system settings declaratively.

### Why Use Home Manager?
Home Manager allows you to manage user-specific settings, making it easier to keep your dotfiles consistent across machines.

## Contributing

Feel free to open issues or submit pull requests if you find any issues or want to add improvements to this configuration.

## License

This repository is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

