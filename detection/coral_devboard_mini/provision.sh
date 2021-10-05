#install mdt
#runs on the pc
pip3 install --user mendel-development-tool
#update your board
echo "SSID Name to Connect?"
read SSID
echo "Password for $SSID?"
read PASS
mdt exec nmcli dev wifi connect "$SSID" password "$PASS" ifname wlan0
sleep 10
mdt exec "sudo dhclient eth0"
mdt exec "sudo apt-get update"
mdt exec "sudo apt-get -y --allow-unauthenticated upgrade"
mdt exec "sudo reboot now"
sleep 45
#install kernel with docker support
mdt install linux-image-4.19.125-mtk_4-2_arm64.deb
mdt exec "sudo reboot now"
sleep 45
mdt exec git clone https://github.com/retrospectsecurity/OSIDS.git
#install docker from the repo
mdt exec curl -fsSL https://get.docker.com -o get-docker.sh
mdt exec sh get-docker.sh
#build docker image mqtt for arm64
mdt exec "git clone https://github.com/brettmiller/docker-mosquitto-arm64.git"
mdt exec "cd docker-mosquitto-arm64 && sudo docker build -t mqtt-arm64 ."
#run arm64 mqtt
mdt exec "sudo docker run --name mqtt --restart=unless-stopped -p 1883:1883 -tid  mqtt-arm64"
#run node-red
#add line to start carnet.sh plugin
mdt exec "sudo apt-get install jshon jq"
mdt exec "sudo docker run -d -p 5001:1880 -v /home/mendel/detection/plugins/node-red:/data -v /home/mendel/OSIDS/detection/plugins/carnet/:/usr/src/node-red/attachment --name node-red --restart=unless-stopped  nodered/node-red"
#install pushover dependency
mdt exec sudo docker exec -it node-red npm install node-red-contrib-pushover
mdt exec "sudo docker restart node-red"
#install the flow and the frigate config file
mdt exec sudo mkdir /media/frigate/
mdt exec sudo chown -Rv mendel:mendel /home/mendel
mdt exec sudo cp OSIDS/detection/coral_devboard_mini/frigate-config.yml /media/frigate/config.yml
mdt exec "sudo docker cp OSIDS/detection/coral_devboard_mini/frigate2pushover.json node-red:/data/flows.json"
mdt exec "sudo docker restart node-red"
#install gotify
docker run  -d --restart=always -p 7005:80 -e TZ="America/New_York" -v /docker/gotify/data:/app/data gotify/server:armv7
#install frigate
mdt exec sudo docker run -d --privileged --restart=unless-stopped --name frigate --mount type=tmpfs,target=/tmp/cache,tmpfs-size=10000000000   --device /dev/bus/usb:/dev/bus/usb   --device /dev/dri/renderD128   -v /media/frigate:/media/frigate   -v /media/frigate/config.yml:/config/config.yml:ro   -v /etc/localtime:/etc/localtime:ro   -e FRIGATE_RTSP_PASSWORD='password'   -p 5000:5000   -p 1935:1935   blakeblackshear/frigate:0.8.4-aarch64
mdt exec sudo touch /media/filebrowser.db
#crontab add line
mdt exec chmod a+x /home/mendel/OSIDS/detection/coral_devboard_mini/clean.sh
#stop frigate until files are edited
mdt exec sudo docker stop frigate
#turn on ssh for mendel user for reconnecting
mdt exec sudo cp /home/mendel/OSIDS/detection/coral_devboard_mini/sshd_config /etc/ssh/sshd_config
mdt exec sudo /etc/init.d/ssh restart
#add the start scripts
mdt exec sudo cp /home/mendel/OSIDS/detection/coral_devboard_mini/kickstart.sh /home/mendel/kickstart.sh
mdt exec sudo cp /home/mendel/OSIDS/detection/coral_devboard_mini/wifi.sh /home/mendel/wifi.sh
mdt exec ln -s /media/frigate/config.yml /home/mendel/config.yml
#turn on phone hotspot for enduser configuration
echo "Hotspot connection info - OSIDS/retrospectsecurity"
#mdt exec nmcli connection delete id "$SSID 1"
#mdt exec nmcli dev wifi connect OSIDS password retrospectsecurity ifname wlan0
echo "Your device IP"
mdt exec sudo ifconfig wlan0
echo "Read the README for further instruction"
