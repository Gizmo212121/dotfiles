#!/usr/bin/bash

set -euo pipefail          # optional, helps catch errors early

sudo -v

sudo evsieve \
  --input  /dev/input/by-id/usb-Logitech_Gaming_Keyboard_G910_067938633135-event-kbd grab \
  --map    yield key:space key:rightctrl \
  --input  /dev/input/by-id/usb-Logitech_Gaming_Keyboard_G910_0B8A346A3831-event-kbd grab \
  --output create-link=/dev/input/by-id/merged-logitech \
  &
EVSIEVE_PID=$!

kanata -c ~/.config/kanata/kanata-merged-logitech.kbd -q
