import os
    
importantApps = "bluez flatpak git discord neovim firefox"

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

print("Welcome to the Arch Setup Helper!\nAt any prompt in the setup simply enter \'s\' to skip \npress ENTER to continue")
input()
clearx()

bro = input("Do you require broadcom? [y/N]: ")
if bro == "y":
    installnc("broadcom-wl")
elif bro == "s":
    print("skipped")
clearx()

vir = input("Do you require virtualization? [y/N]: ") 
if vir == "y":
    installnc(importantApps + " virtualbox linux-headers")
elif vir == "s":
    print("skipped")
else:
    installnc(importantApps)
    os.system("sudo systemctl enable bluetooth.service && sudo systemctl start bluetooth.service")
    finstall("spotify -y")

clearx()

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
elif de == "s":
    print("skipped")
else:
    install(de)
clearx()

dm = input("And for the display manager?: ")
if dm == "s":
    print("skipped")
else:
    installnc(dm)
    os.system("sudo systemctl enable " + dm)
    os.system("sudo systemctl start " + dm)
