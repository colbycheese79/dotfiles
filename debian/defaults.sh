#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating package lists and installing i3 Window Manager environment on Debian..."
sudo apt update

# Organize X11 and i3 packages into readable categories
PACKAGES=(
    # --- Core X11 Server & Input ---
    xorg xinput

    # --- i3 Window Manager & Spicing ---
    i3 i3status autotiling python3-i3ipc picom feh

    # --- System Utilities & Daemons ---
    rsync curl wget htop fwupd lxpolkit libglib2.0-bin cups synaptic

    # --- Development & Compilation Headers ---
    build-essential suckless-tools libxkbcommon-dev libxft-dev libx11-dev 
    libxinerama-dev libncurses-dev

    # --- Audio, Media & Gaming ---
    pipewire-audio pavucontrol pulsemixer playerctl mpv gamemode wine

    # --- Application Launcher & Notifications ---
    rofi dunst libnotify-bin

    # --- File Manager & Core Apps ---
    pcmanfm xarchiver galculator geany sxiv scrot

    # --- Look & Feel (GTK, Icons, Themes) ---
    lxappearance gnome-themes-extra gtk2-engines-murrine papirus-icon-theme

    # --- Fonts ---
    fonts-ubuntu fonts-dejavu fonts-font-awesome fonts-liberation2 
    fonts-recommended fonts-noto fonts-roboto
)

# Install packages with automatic "yes" confirmation
sudo apt install -y "${PACKAGES[@]}"

# --- Post-Installation Configuration ---

echo "Enabling and starting system services..."

# Enable and start CUPS (Printing)
sudo systemctl enable --now cups.service

echo "Installation complete! You can now type 'startx' from the tty (if configured),"
echo "or select i3 from your preferred display manager login screen."
