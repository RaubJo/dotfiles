#!/bin/bash

# Terminate already running polybars
killall -q polybar

# Wait for the process(es) to be shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar using the default config location
polybar joseph &

echo "Polybar launched..."
