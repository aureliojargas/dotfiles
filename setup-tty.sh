#!/bin/sh
# Setup for minimal Debian install (text mode)
# Requirements: sudo

# hardware shortcuts to avoid installing extra software
if ! test -d /hardware
then
    sudo mkdir /hardware
    sudo ln -sv /sys/class/power_supply/BAT0/capacity               /hardware/battery
    sudo ln -sv /sys/class/power_supply/BAT0/status                 /hardware/battery-status
    sudo ln -sv /sys/class/backlight/intel_backlight/brightness     /hardware/brightness-current
    sudo ln -sv /sys/class/backlight/intel_backlight/max_brightness /hardware/brightness-max
    sudo ln -sv /etc/network/interfaces                             /hardware/wifi-password
    sudo ln -sv /proc/net/wireless                                  /hardware/wifi-signal
    echo 'journalctl -xe; read; sudo dmesg -w' | sudo tee /hardware/error-logs
fi

# apt
if ! test -f /etc/apt/apt.conf.d/69noinstallrecommends
then
    echo 'APT::Install-Recommends "false";' | sudo tee /etc/apt/apt.conf.d/69noinstallrecommends
fi

sudo apt update
# base
sudo apt install git ssh vim tree tig curl ca-certificates man python3 gpm sudo make zram-tools
# backups
sudo apt install unzip rsync exfatprogs xz-utils hdparm
# docker
sudo apt install podman uidmap libpam-systemd dbus-user-session passt
