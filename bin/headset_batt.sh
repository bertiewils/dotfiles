#!/usr/bin/env bash

# Script to return a pretty battery status of the connected headset using https://github.com/Sapd/HeadsetControl

HEADSETCONTROL_BIN="/usr/local/bin/headsetcontrol"
HEADSETCONTROL_BATT="-b"
HEADSETCONTROL_QUIET="-c"

OUTPUT=$(${HEADSETCONTROL_BIN} ${HEADSETCONTROL_BATT} ${HEADSETCONTROL_QUIET})

case "${OUTPUT}" in
    -1)    STATUS="Charging";;
    -2)    STATUS="Disconnected";;
    *)     STATUS="${OUTPUT} %";;
esac

echo "Headset: $STATUS"
