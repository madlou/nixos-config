{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    systemd-boot.configurationLimit = 5;
  };
  
  console.keyMap = "uk";
  
  environment.systemPackages = with pkgs; [
    transmission_4-qt
    wine
    pwsafe
    tor-browser
    git
    # vscode
    deskflow
    discord
    appimage-run
    bitwarden-desktop
  ];
    
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
  
  networking = {
    hostName = "rog";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 24800 ];
    firewall.allowedUDPPorts = [ 24800 ];
    firewall.enable = true;
  };
  
  programs = {
    firefox.enable = true;
    geary.enable = true;
  };
  
  nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # "electron-39.8.10"
    ];
  };

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    openssh.enable = true;
    plex = {
      enable = true;
      openFirewall = true;
      user="lewis";
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      xkb = {
        layout = "gb";
        variant = "";
      };
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
    logind.settings.Login.HandleLidSwitch = "ignore";
  };

  security.rtkit.enable = true;
  
  system.stateVersion = "26.05";

  systemd.settings.Manager.DefaultTimeoutStopSec = "5s";
  
  time.timeZone = "Europe/London";
  
  users.users.lewis = {
    isNormalUser = true;
    description = "lewis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [  ];
  };

}

