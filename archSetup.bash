#!/bin/bash

clear 

apps="bluez flatpak git discord neovim firefox"
dmdefault="empty"

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
includes $apps spotify(flatpak) [Y/n]: " appask

if [ $appask == "n" ]; then
elif [ $appask == "s" ]; then
  echo "skipped"
else
  sudo pacman -S $apps --noconfirm
  flatpak install spotify -y
  sudo systemctl enable bluetooth
fi

clear

read -p "Prefered desktop enviroment?: " de 

if [ de == "s" ]; then
  echo "skipped"
elif [ $de == "kde" ]; then
  read -p "Would you prefer a minimal installation? [y/N]: " kdeMin
  if [ $kdeMin == "y" ]; then
    sudo pacman -S plasma-desktop konsole --noconfirm
  else
    sudo pacman -S plasma --noconfirm
  fi
  dmdefault="sddm"
elif [ $de == "gnome" ] || [ $de == "mate" ] || [ $de == "deepin" ]; then
  read -p "Would you like extra $de applications? [y/N]: " extra
  sudo pacman -S $de --noconfirm
  if [ $de == "deepin" ]; then
    sudo pacman -S deepin-kwin --noconfirm
    dmdefault="lightdm lightdm-deepin-greeter"
  elif [ $de == "gnome" ]; then
    sudo pacman -S gnome-tweaks
    dmdefault="gdm"
    if [ $appask == "y" ]; then 
      flatpak install org.install.Platform -y
    fi
  fi
  if [ $extra == "y" ]; then
    sudo pacman -S ${de}-extra --noconfirm
  fi
elif [ $de == "budgie" ]; then 
  sudo pacman -S budgie nautilus --noconfirm
fi

clear

if [ $dmdefault == "empty" ]; then
  read -p "prefered display manager?: " dm
else
  read -p "Would you like to install the default display manager? ($dmdefault) [Y/n]: " dfltconfirm
  if [ $dfltconfirm == "s" ]; then
    echo "skipped"
  elif [ $dfltconfirm == "n" ]; then
    read -p "prefered display manager?: " dm
  else
    dm=$dmdefault
  fi
fi

if [ $dfltconfirm == "s" ]; then 
elif [ $dm == "s" ]; then
  echo "skipped"
else
  sudo pacman -S $dm
  if [ $dm == "lightdm" ]; then
    sudo pacman -Ss lighdm | grep lightdm
    echo "please choose one of these"
    read -p "lightdm-" greeter
    sudo pacman -S lightdm-$greeter
  else
  fi
fi
