{ config, lib, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "x2";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  
  console.keyMap = "uk";
    
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  
  services.printing.enable = true;
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.lewis = {
    isNormalUser = true;
    description = "lewis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [  ];
  };

  programs.firefox.enable = true;
  
  nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    wine
    pavucontrol
    discord
    (callPackage ./turtle-wow/default.nix { })
  ];

  services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  
  systemd.settings.Manager.DefaultTimeoutStopSec = "30s";

  system.copySystemConfiguration = true;
  system.stateVersion = "25.11";

}

