#!/bin/bash
#An "AUDIO issue" bash script 
#This was put into the HP Device Manager as a pushable script to fix Audio issues on HP t630 thinclients running HP's Linux distro.

# Get the name of the microphone device
mic=$(pacmd list-sources | awk '/index/ {i=$2} /name:/ && /input/ {if ($0~"usb") print i}')

# Check if the microphone is muted
if [[ $(pacmd list-sources | grep -A 15 "index: $mic") =~ "muted: yes" ]]; then
    # Unmute the microphone
    pacmd set-source-mute $mic 0
    echo "Microphone unmuted."
else
    echo "Microphone is already unmuted."
fi

 Set the audio speakers to 100%
amixer set Master 100%

# Set all devices to default
pacmd set-default-sink "$(pacmd list-sinks | grep -oP 'index:\s*\K\d+')"

echo "Audio speakers set to 100% and all devices set to default."