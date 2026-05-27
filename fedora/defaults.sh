#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating DNF repositories and installing Sway environment on Fedora..."

# Organize Fedora packages into readable categories
PACKAGES=(
    # --- Core Wayland & Sway ---
    sway i3status autotiling python3-i3ipc wl-clipboard clipman

    # --- System Utilities & Daemons ---
    tar wget fuse fuse-libs usbutils avahi fastfetch htop fwupd
    lxpolkit gnome-keyring gnome-keyring-pam seahorse
    cups system-config-printer

    # --- Audio, Video & Codec Groups ---
    @multimedia 
    @sound-and-video
    mpv playerctl

    # --- Gaming & Compatibility ---
    wine lutris gamemode flatpak

    # --- Core Desktop Apps & Shell ---
    firefox fish neovim geany galculator imv papers simple-scan

    # --- File Manager & Plugins ---
    thunar thunar-volman thunar-archive-plugin tumbler tumbler-extras file-roller

    # --- Look & Feel (GTK, Icons, Themes) ---
    lxappearance gnome-themes-extra papirus-icon-theme papirus-icon-theme-dark
    
    # --- Launcher & Notifications ---
    fuzzel dunst

    # --- Fonts ---
    google-noto-emoji-fonts
)

# Install packages using DNF
sudo dnf install -y "${PACKAGES[@]}"

echo "Configuring flatpak repositories..."
# Add Flathub repository cleanly
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Enabling and starting system services..."
# Enable and start printer/network sharing daemons in one shot
sudo systemctl enable --now cups.service
sudo systemctl enable --now avahi-daemon.service

echo "Installation complete! Reboot or log out to access your fresh Sway desktop."
