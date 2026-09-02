# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking & Localization
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Hardware & Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # for games
  };

  # Services
  services.gvfs.enable = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
  description = "polkit-gnome-authentication-agent-1";
  wantedBy = [ "graphical-session.target" ];
  wants = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];
  serviceConfig = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;
  };
};

  # Programs & Shell
  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # User Account
  users.users.colby = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    autotiling
    brave
    dunst
    dxvk
    file-roller
    fish
    fuzzel
    galculator
    geany
    gh
    git
    gnome-themes-extra
    gvfs
    i3status
    lutris
    mpv
    neovim
    nwg-look
    papirus-icon-theme
    papers
    simple-scan
    thunar
    thunar-archive-plugin
    thunar-volman
    wget
    wineWow64Packages.staging
    wl-clipboard
    wowup-cf
  ];

  # File Systems
  fileSystems."/home/colby/backups" = {
    device = "/dev/disk/by-uuid/85396fc7-c062-44c1-939b-22357c8e82fb";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

  # State Version
  system.stateVersion = "26.05";
}
