#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating system and installing Sway environment..."

# Organize packages into readable categories
PACKAGES=(
    # --- Core Wayland & Sway ---
    sway swaylock swayidle swaybg i3status autotiling uwsm seatd wl-clipboard 
    xorg-xwayland xdg-desktop-portal-gtk xdg-desktop-portal-wlr

    # --- System Utilities & Daemons ---
    pacman-contrib rsync fastfetch polkit-gnome fwupd man-db cups ipp-usb ghostscript

    # --- Audio & Media ---
    pipewire pipewire-pulse wireplumber playerctl mpd mpv

    # --- Terminal & Shell Tools ---
    foot vim

    # --- Application Launcher & Notifications ---
    fuzzel dunst

    # --- File Manager & Core Desktop Apps ---
    thunar thunar-archive-plugin thunar-volman tumbler gvfs xarchiver 
    papers simple-scan flatpak galculator geany imv

    # --- Look & Feel (GTK, Icons, Themes) ---
    lxappearance nwg-look materia-gtk-theme gnome-themes-extra 
    papirus-icon-theme libadwaita

    # --- Fonts ---
    otf-font-awesome noto-fonts-emoji ttf-croscore ttf-dejavu ttf-droid 
    gnu-free-fonts ttf-liberation noto-fonts ttf-roboto ttf-ubuntu-font-family
)

# Install packages
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# --- Post-Installation Configuration ---

echo "Enabling and starting system services..."

# Enable and start CUPS (Printing) in a single command
sudo systemctl enable --now cups.service

echo "Installation complete! You can now launch Sway via UWSM using: uwsm start sway (reboot may be required)"
