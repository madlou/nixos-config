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
  boot.loader.systemd-boot.configurationLimit = 5;

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
  services.logind.settings.Login.HandleLidSwitch = "ignore";

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
  programs.geary.enable = true;
  
  nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    transmission_4-qt
    wine
    pwsafe
    tor-browser
    git
    vscode
    deskflow
    discord
    appimage-run
    bitwarden-desktop
  ];

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 24800 ];
  networking.firewall.allowedUDPPorts = [ 24800 ];
  networking.firewall.enable = true;
  
  services.plex = {
    enable = true;
    openFirewall = true;
    user="lewis";
  };
  
  inputs.whisper-dictation.url = "github:jacopone/whisper-dictation";

  # In your configuration
  environment.systemPackages = [
    inputs.whisper-dictation.packages.${system}.default
  ];
  
  systemd.settings.Manager.DefaultTimeoutStopSec = "5s";

  system.stateVersion = "26.05";
  
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];


}

