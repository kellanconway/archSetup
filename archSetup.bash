#!/bin/bash

clear 

apps="bluez flatpak git discord neovim firefox"

read -p "Welcome to the Arch Setup Assistant!
At any prompt in the setup simply enter 's' to skip 
press ENTER to continue" nothing
clear 

read -p "Do you require broadcom? [y/N]: " broadcom
if [ $broadcom == "y" ]; then
  sudo pacman -S broadcom-wl --noconfirm
elif [ $broadcom == "s" ]; then
  echo "skipped"
else
  echo ""
fi
clear 

read -p "Do you require virtualization? [y/N]: " vbox
if [ $vbox == "y" ]; then
  read -p "What kernel do are you using? (linux, linux-lts, linux-hardened, linux-zen): " kernel
  sudo pacman -S $kernel-headers --noconfirm #TODO: make this idiot proof
  clear 
  if [ $kernel == "linux" ]; then
    echo "IMPORTANT!!: choose 'virtualbox-host-modules-arch'

    "
  else
    echo "IMPORTANT!!: choose 'virtualbox-host-dkms'

    "
  fi
  sudo pacman -S virtualbox --noconirm
elif [ $vbox == "s" ]; then
  echo "skipped"
fi

clear

read -p "Would like to install app list?
includes $apps [Y/n]: " appask

if [ $appask == "n" ]; then
elif [ $appask == "s"]; then
  echo "skipped"
else
  sudo pacman -S $apps --noconfirm
  flatpak install 
fi

clear

read -p "Prefered desktop enviroment?: " de 

if [ de == "s" ]; then
  echo "skipped"
elif [ $de == "kde" ]; then
  read -p "Would you prefer a minimal installation? [y/N]: " kdeMin
  if [ $kdeMin == "y"]; then
    sudo pacman -S plasma-desktop konsole --noconfirm
  else
    sudo pacman -S plasma --noconfirm
  fi
elif [ $de == "gnome" ] || [ $de == "mate" ] || [ $de == "deepin" ]
  read -p "Would you like extra $de applications? [y/N]: " extra
  sudo pacman -S $de --noconfirm
  if [ $de == "deepin" ]; then
    sudo pacman -S deepin-kwin --noconfirm
  elif [ $de == "gnome" ]; then
    sudo pacman -S gnome-tweaks
    if [ $appask == "y" ]; then
      flatpak install org.install.Platform -y
    fi
  fi
  if [ $extra == "y" ]; then
    sudo pacman -S ${de}-extra --noconfirm
  fi
elif [ $de == "budgie"]; then 
  sudo pacman -S budgie nautilus --noconfirm
fi

clear

read -p "prefered display manager?: " dm

if [ $dm == "s" ]; then
  echo "skipped"
else
  if [ appask == "y" ]; then
    sudo systemctl enable bluetooth
    sudo systemctl enable bluetooth
  fi
  sudo pacman -S $dm --noconfirm
  sudo systemctl enable $dm
  sudo systemctl start $dm
fi



