#!/bin/bash

# If parameter 1, then increase brightness
# If parameter -1, then decrease brightness
# If invalid or no parameter, then exit

if [[ -z "$1" ]]
then
    exit 0
fi

#Max brightness from /sys/class/backlight/intel_backlight/max_brightness
#cat /sys/class/backlight/intel_backlight/max_brightness
#4810 in my case, but have set 4800 as max

max_brightness=4800
min_brightness=0
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

#echo $current_brightness

if [[ $1 -eq 1 ]]
then
    new_brightness=$((current_brightness + 400))
elif [[ $1 -eq -1 ]]
then
    new_brightness=$((current_brightness - 400))
else
    exit 0
fi

if [ $new_brightness -lt $min_brightness ]
then
    new_brightness=$min_brightness
elif [ $new_brightness -gt $max_brightness ]
then
    new_brightness=$max_brightness
fi

#echo $new_brightness

# Need to set brightness as writable by all, so that sudo / su -c
# is not required
# chmod 666 /sys/class/backlight/intel_backlight/brightness

echo $new_brightness > /sys/class/backlight/intel_backlight/brightness
