#!/bin/bash

# Shutdown options
options="Shutdown\nReboot\nLock\nLogout\nCancel"

# Using Rofi to show menu 
choice=$(echo -e "$options" | rofi -dmenu -theme ~/.config/i3-custom/rofi/themes/darkblue -p "Shutdown/Options")

case "$choice" in
    "Shutdown")
        poweroff
        ;;
    "Reboot")
        reboot
        ;;
    "Lock")
        i3lock
        ;;
    "Logout")
        i3-msg exit
        ;;
    "Cancel")
        exit 0
        ;;
    *)
        exit 1
        ;;
esac
