#1/bin/bash
echo "Connect over USB OTG"
sleep 10
mdt reboot-bootloader
curl -O https://mendel-linux.org/images/excelsior/eagle/excelsior-eagle-20201210233645.zip
unzip excelsior-eagle-20201210233645.zip
cd excelsior-eagle-20201210233645
bash flash.sh
