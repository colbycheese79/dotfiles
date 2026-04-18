#!/bin/bash
sudo dpkg --add-architecture i386 &&
sudo apt update &&
sudo apt install -t trixie-backports libegl-mesa0 libgbm1 libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers &&
sudo apt install -t trixie-backports steam libgl1-mesa-dri:i386 mesa-vulkan-drivers:i386
