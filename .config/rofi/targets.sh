#!/usr/bin/env bash
set -euo pipefail

menu() {
  cat <<'EOF'
Shutdown
Reboot
Lock
Log out
EOF
}

run_cmd() {
  case "$1" in
    "Shutdown")
      exec systemctl poweroff >/dev/null 2>&1
      ;;
    "Reboot")
      exec systemctl reboot >/dev/null 2>&1
      ;;
    "Lock")
      if command -v hyprlock >/dev/null 2>&1; then
        # Start hyprlock detached, silence all output, and end this script immediately
        setsid -f hyprlock >/dev/null 2>&1 || true
        exit 0
      else
        exec loginctl lock-session >/dev/null 2>&1
      fi
      ;;
    "Log out")
      # Try Hyprland logout; if that fails, fall back to terminating the user session
      exec hyprctl dispatch exit >/dev/null 2>&1 || exec loginctl terminate-user "$USER" >/dev/null 2>&1
      ;;
  esac
}

if [ -z "${1-}" ]; then
  menu
else
  run_cmd "$1"
fi
