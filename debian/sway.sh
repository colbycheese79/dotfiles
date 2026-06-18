#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating package lists and installing Sway environment on Debian..."
sudo apt update

# Organize Debian packages into readable categories
PACKAGES=(
    # --- Core Wayland & Sway ---
    sway swaylock swayidle swaybg i3status autotiling seatd wl-clipboard 
    xwayland xdg-desktop-portal-gtk xdg-desktop-portal-wlr python3-i3ipc

    # --- System Utilities & Daemons ---
    libfuse2t64 curl fwupd fastfetch lxpolkit libglib2.0-bin cups build-essential light

    # --- Audio, Media & Gaming ---
    pipewire-audio playerctl mpd mpv gamemode

    # --- Terminal & Shell Tools ---
    foot gh

    # --- Application Launcher & Notifications ---
    fuzzel dunst

    # --- File Manager & Desktop Apps ---
    pcmanfm file-roller galculator imv

    # --- Look & Feel (GTK, Icons, Themes) ---
    nwg-look arc-theme gtk2-engines-murrine papirus-icon-theme

    # --- Fonts ---
    fonts-dejavu fonts-font-awesome fonts-liberation2 fonts-noto fonts-roboto
)

# Install packages with automatic "yes" confirmation
sudo apt install -y "${PACKAGES[@]}"

# --- Post-Installation Configuration ---

echo "Enabling and starting system services..."

# Enable and start CUPS (Printing)
sudo systemctl enable --now cups.service

echo "Installation complete! You can log out and select Sway from your display manager,"
echo "or run 'sway' directly from a tty login."
