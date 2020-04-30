#!/bin/bash

#
#   James Walters
#   james_b_walters@yahoo.commands
#   30 APR 2020
#
#   This is a GUI to control the Logitech C920 camera.
#   This GUI is configured to set the C920 parameters
#   to their default values, except for AutoFocus,
#   which is set FALSE, and the FOCUS_ABSOLUTE which will
#   be set to 0.
#
#   The following programs must be installed for this GUI to work:
#   awk
#   YAD
#   The v4l-utils camera utilities


#
#   Command to list the available cameras
#

  v4l2-ctl  --list-devices  > device_report.txt

  DEVICE_REPORT=$(cat device_report.txt)

#
# Camera selection default
#

DEVICE="/dev/video0"


#
#   Menu for YAD
#


  DEVICE_CONFIG_CMD=$( yad   --title="Video Camera Configuration" \
        --text "$DEVICE_REPORT" \
        --image "/usr/share/icons/C920.jpeg" \
        --form --separator="," --item-separator="," \
        --field="Enter Video Camera Device:" "$DEVICE" \
        --field "Auto Focus":chk false \
        --field="Focus [0-250]:NUM" '0!0..250!5' \
        --field "Auto Exposure":chk true \
        --field "Exposure [3-2047]:NUM" '250!3..2047!1' \
        --field "Backlight Compensation":chk false \
        --field="Brightness [0-255]:NUM" '128!0..255!1' \
        --field="Contrast [0-255]:NUM" '128!0..255!1' \
        --field="Saturation [0-255]:NUM" '128!0..255!1' \
        --field="White Balance Temp Auto":CHK true \
        --field="White Balance Temp [2000-6500]:NUM" '4000!2000..6500!1')

  echo $DEVICE_CONFIG_CMD > device_command.txt

#
# Get the results of the menu entry
#

  DEVICE=$(awk 'BEGIN{FS=","; OFS=","}{print $1}' device_command.txt)
  focus_auto=$(awk 'BEGIN{FS=","; OFS=","}{print $2}' device_command.txt)
  focus_absolute=$(awk 'BEGIN{FS=","; OFS=","}{print $3}' device_command.txt)
  exposure_auto=$(awk 'BEGIN{FS=","; OFS=","}{print $4}' device_command.txt)
  exposure_absolute=$(awk 'BEGIN{FS=","; OFS=","}{print $5}' device_command.txt)
  backlight_compensation=$(awk 'BEGIN{FS=","; OFS=","}{print $6}' device_command.txt)
  brightness=$(awk 'BEGIN{FS=","; OFS=","}{print $7}' device_command.txt)
  contrast=$(awk 'BEGIN{FS=","; OFS=","}{print $8}' device_command.txt)
  saturation=$(awk 'BEGIN{FS=","; OFS=","}{print $9}' device_command.txt)
  white_balance_temperature_auto=$(awk 'BEGIN{FS=","; OFS=","}{print $10}' device_command.txt)
  white_balance_temperature=$(awk 'BEGIN{FS=","; OFS=","}{print $11}' device_command.txt)

#
# Issue the control commands to the camera
#

  if [[ "$focus_auto" = "true" ]]
  then
    CMD1=$(v4l2-ctl -d "$DEVICE" -c focus_auto=1)
#    echo "Auto Focus Enabled"
  else
    CMD1=$(v4l2-ctl -d "$DEVICE" -c focus_auto=0)
    CMD5=$(v4l2-ctl -d "$DEVICE" -c focus_absolute=$focus_absolute)
#    echo "Auto Focus Disabled, Focus set to "$focus_absolute
  fi

  if [[ "$exposure_auto" = "TRUE" ]]
  then
    CMD2=$(v4l2-ctl -d "$DEVICE" -c exposure_auto=3)
  else
    CMD2=$(v4l2-ctl -d "$DEVICE" -c exposure_auto=1)
    CMD8=$(v4l2-ctl -d "$DEVICE" -c exposure_absolute=$exposure_absolute)
  fi

  if [[ "$backlight_compensation" = "TRUE" ]]
  then
    CMD3=$(v4l2-ctl -d "$DEVICE" -c backlight_compensation=1)
  else
    CMD3=$(v4l2-ctl -d "$DEVICE" -c backlight_compensation=0)
  fi

   CMD4=$(v4l2-ctl -d "$DEVICE" \
   -c brightness=$brightness, \
   -c contrast=$contrast, \
   -c saturation=$saturation
  )

  if [[ "$white_balance_temperature_auto" = "TRUE" ]]
  then
    CMD6=$(v4l2-ctl -d "$DEVICE" -c white_balance_temperature_auto=1)
  else
    CMD6=$(v4l2-ctl -d "$DEVICE" -c white_balance_temperature_auto=0)
    CMD7=$(v4l2-ctl -d "$DEVICE" -c white_balance_temperature=$white_balance_temperature)
  fi

exit 0
