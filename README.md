# Logitch-C920-Linux-GUI
This is a GUI to control the Logitech C920 camera.

James Walters
james_b_walters@yahoo.commands
30 APR 2020

This is a GUI to control the Logitech C920 camera.
This GUI is configured to set the C920 parameters
to their default values, except for AutoFocus,
which is set FALSE, and the FOCUS_ABSOLUTE which will
be set to 0.

videosetup.sh provides the user a small menu of buttons to launch preferred applications, and can call c920setup.sh.
c920setup.sh is the script that configures the Logitech C920 webcam.

The following programs must be installed for this GUI to work:
   awk
   YAD
   The v4l-utils camera utilities
