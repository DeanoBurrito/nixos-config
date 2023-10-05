{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware/framework13.nix
      ./modules/text.nix
      ./modules/media.nix
      ./modules/hyprland.nix
      ./users/dean.nix
    ];

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
    	systemd-boot.enable = true;
	systemd-boot.editor = false;
	efi.canTouchEfiVariables = true;
	timeout = 0;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."vm.swappiness" = 10;
  };

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  hardware.bluetooth.enable = true;

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session.user = "greeter";
	default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --issue";
      };
    };

    openssh.enable = true;
    openssh.ports = [ 4444 ];
    openssh.banner = (builtins.readFile /etc/issue);
    dbus.enable = true;
  };

  systemd.services.greetd = {
    unitConfig = {
      After = [ "multi-user.target" ];
    };
    serviceConfig = {
      Type = "idle";
    };
  };

  environment.etc."greetd/environments".text = "Hyprland";

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.enable = true;
    sudo.execWheelOnly = true;
    sudo.wheelNeedsPassword = true;
  };

  time.timeZone = "Australia/Sydney";

  environment.systemPackages = with pkgs; [
    # Core utils
    coreutils
    pciutils
    brightnessctl
    
    # Admin tools
    neovim
    git
    curl
    wget
    htop
    ranger
    unzip
  ];

  environment.sessionVariables = {
    EDITOR="nvim";
  };

  system.stateVersion = "23.05"; # Did you read the comment?
}
