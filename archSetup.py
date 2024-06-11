import os
    
importantApps = "flatpak git discord neovim firefox"

def clear():
    os.system("clear")
def clearx(): 
    os.system("clear -x")
def installnc(x):
    os.system("sudo pacman -S " + x + " --noconfirm")
def install(x):
    os.system("sudo pacman -S " + x)
def finstall(x):
    os.system("sudo flatpak install " + x);
clear()

print("Welcome to the Arch Setup Helper! \n\npress ENTER to continue")
input()

if input("Do you require broadcom? [y/N]: ") == "y":
    installnc("broadcom-wl")
else:
    pass

clearx()

if input("Do you require virtualization? [y/N]: ") == "y":
    installnc(importantApps + " virtualbox linux-headers")
else:
    installnc(importantApps)
finstall("spotify -y")

de = input("prefered desktop environment?: ")

if de == "gnome":
    installnc("gnome")
    installnc("gnome-tweaks")
    finstall("org.install.Platform")
elif de == "kde" or de == "plasma":
    if input("Would you like kde applications [y/N]: ") == "y":
        installnc("plasma")
    else:
        installnc("plasma-desktop")
elif de == "mate":
    if input("Would you like MATE applications [y/N]: ") == "y":
        installnc("mate mate-extra")
    else:
        installnc("mate")
elif de == "deepin":
    if input("Would you like deepin applications [y/N]: ") == "y":
        installnc("deepin deepin-kwin")
    else:
        installnc("deepin deepin-kwin deepin-extra")
elif de == "budgie":
    installnc("budgie")
    installnc("nautilus")
else:
    install(de)
clearx()

dm = input("And for the display manager?: ")
installnc(dm)
os.system("sudo systemctl enable " + dm)
os.system("sudo systemctl start " + dm)
