#!/bin/bash
BRIGHTNESS_VALUE=`brightnessctl | grep -o "(.*" | tr -d "()"`
BRIGHTNESS_NR=${BRIGHTNESS_VALUE//%}

if [ $BRIGHTNESS_NR -lt 25 ]; then
	BRIGHTNESS_ICON='󰃞'
elif [ $BRIGHTNESS_NR -lt 75 ]; then
	BRIGHTNESS_ICON='󰃟'
else
	BRIGHTNESS_ICON='󰃠'
fi

echo "$BRIGHTNESS_ICON  $BRIGHTNESS_VALUE"
