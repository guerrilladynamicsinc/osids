sudo docker run --name mqtt --restart=always -p 1883:1883 -tid toke/mosquitto4
#run node-red
sudo docker run -d -p 5001:1880 --name node-red --restart=always  nodered/node-red
#install pushover dependency
sudo docker exec -it node-red "npm install node-red-contrib-pushover
sudo docker restart node-red
#install the flow and the frigate config file
sudo mkdir /media/frigate/
sudo cp frigate-config.yml /media/frigate/config.yml
sudo docker cp frigate2pushover.json node-red:/data/flows.json
sudo docker restart node-red
#install frigate
sudo docker run -d --name frigate   --restart=always   --mount type=tmpfs,target=/tmp/cache,tmpfs-size=10000000000   --device /dev/bus/usb:/dev/bus/usb   --device /dev/dri/renderD128   -v /media/frigate:/media/frigate   -v /media/frigate/config.yml:/config/config.yml:ro   -v /etc/localtime:/etc/localtime:ro   -e FRIGATE_RTSP_PASSWORD='password'   -p 5000:5000   -p 1935:1935   blakeblackshear/frigate:0.8.4-amd64
echo "Edit your config file at http://ODIDSIP:5002 - login with admin/admin"
echo "Make sure the mqtt matches youe device IP in node-red and frigate config"
echo "Edit your notification setup at http://OSIDSIP:5001"
echo "Edit your masks and frigate at http://OSIDSIP:5000"
