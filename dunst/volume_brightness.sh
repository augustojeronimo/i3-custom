#!/bin/bash

parse_variation() {
    VALUE=$(echo "$1" | grep -o '[0-9]\+')
    OPERATOR=$(echo "$1" | grep -o '[+-]')
    
    if [ -z "$VALUE" ] || [ -z "$OPERATOR" ]; then
        echo "Error: The second parameter must follow the format '5+' or '5-'."
        exit 1
    fi
}

adjust_volume() {
    VOL_MAX=150
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
    MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    parse_variation "$1"

    if [ "$OPERATOR" = "+" ]; then
        NEW_VOL=$((VOL + VALUE))
    else
        NEW_VOL=$((VOL - VALUE))
    fi

    if [ "$NEW_VOL" -gt "$VOL_MAX" ]; then
        NEW_VOL=$VOL_MAX
    elif [ "$NEW_VOL" -lt 0 ]; then
        NEW_VOL=0
    fi

    pactl set-sink-volume @DEFAULT_SINK@ "$NEW_VOL%"

    if [ "$MUTE" = "yes" ]; then
        MESSAGE="$NEW_VOL% (muted)"
    else
        MESSAGE="$NEW_VOL%"
    fi

    dunstify -t 1000 -r 9995 -h int:value:"$NEW_VOL" "Volume" "$MESSAGE"
}

adjust_brightness() {
    MAX_BRIGHT=$(brightnessctl max)
    BRIGHT=$(brightnessctl get)
    parse_variation "$1"

    VARIATION=$((MAX_BRIGHT * VALUE / 100))

    if [ "$OPERATOR" = "+" ]; then
        brightnessctl set "$VARIATION+"
    else
        brightnessctl set "$VARIATION-"
    fi

    BRIGHT=$(brightnessctl get)
    BRIGHT_PERC=$((BRIGHT * 100 / MAX_BRIGHT))
    
    dunstify -t 1000 -r 9994 -h int:value:"$BRIGHT_PERC" "Brightness" "$BRIGHT_PERC%"
}

toggle_mute() {
    MUTE_STATE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
    
    if [ "$MUTE_STATE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ no
        MESSAGE="$VOL%"
    else
        pactl set-sink-mute @DEFAULT_SINK@ yes
        MESSAGE="$VOL% (Muted)"
    fi

    dunstify -t 1000 -r 9995 -h int:value:"$VOL" "Volume" "$MESSAGE"
}

case "$1" in
    volume)
        if [ "$2" = "mute" ]; then
            toggle_mute
        elif [ -z "$2" ]; then
            echo "Please provide a variation value in the format '5+' or '5-'."
            exit 1
        else
            adjust_volume "$2"
        fi
        ;;
    brightness)
        if [ -z "$2" ]; then
            echo "Please provide a variation value in the format '5+' or '5-'."
            exit 1
        else
            adjust_brightness "$2"
        fi
        ;;
    *)
        echo "Usage: $0 {volume|brightness} <variation>"
        exit 1
        ;;
esac
