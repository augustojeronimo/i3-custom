#!/bin/bash

# Opções de desligamento
options="Shutdown\nReboot\nLock\nCancel"

# Usando o rofi para mostrar o menu
choice=$(echo -e "$options" | rofi -dmenu -theme ~/.config/i3-custom/rofi/themes/darkblue -p "Shutdown/Options")

# Realizando ação de acordo com a escolha
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
    "Cancel")
        exit 0
        ;;
    *)
        exit 1
        ;;
esac
