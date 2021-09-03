#!/bin/bash
#set wifi name for enduser
#runs on the coral board
echo "Enter Wifi SSID"
read SSID
echo "Enter Wifi Password"
read PASS
echo "Wifi: $SSID / Pass: $PASS"
sudo nmcli dev wifi connect "$SSID" password "$PASS" ifname wlan0
sudo ifconfig wlan0
