{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

  networking.hostName = "rog";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
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

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  console.keyMap = "uk";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  services.xserver.videoDrivers = [ "nvidia" ];

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
    transmission_4-qt
    wine
    pwsafe
    tor-browser
    git
  ];

  services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  
  services.plex = {
    enable = true;
    openFirewall = true;
    user="lewis";
  };
  
  systemd.settings.Manager.DefaultTimeoutStopSec = "30s";

  system.stateVersion = "25.11"; # Did you read the comment?

}

