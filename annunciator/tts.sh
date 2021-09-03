#!/bin/bash
WAV=/home/talkkonnect/gocode/src/github.com/talkkonnect/talkkonnect/soundfiles/rogerbeeps/Image.wav
pico2wave -w=$WAV "$1"
curl http://localhost:8080/?command=RepeatTxLoop
sleep 3
rm $WAV
