#!/bin/bash

#
#   James Walters
#   james_b_walters@yahoo.commands
#   30 APR 2020
#
#   This is a GUI to call the Logitech C290 setup script,
#   as well as a couple other programs I use.
#   The following programs must be installed for this GUI to work.
#   The user can replace my choice of additional applications
#   with their personal preferences.
#
#   This script will require the following programs to work:
#   YAD



  DEVICE_CONFIG_CMD=$( yad   --title="Video Setup" \
        --text "$DEVICE_REPORT" \
        --image "/usr/share/icons/C920.jpeg" \
        --form --separator="," --item-separator="," \
        --field="C290 Setup":fbtn "c290setup.sh" \
        --field="Cheese":fbtn "cheese" \
        --field="Screen Capture":fbtn "simplescreenrecorder --logfile" \
        --field="ZOOM":fbtn "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=zoom --file-forwarding us.zoom.Zoom @@u %U @@" \
        --button="gtk-quit":0 )

exit 0
