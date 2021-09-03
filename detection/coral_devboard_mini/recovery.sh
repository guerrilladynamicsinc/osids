#1/bin/bash
#runs on the pc
echo "Connect over USB OTG"
echo "going to /tmp/"
cd /tmp
sleep 10
mdt reboot-bootloader
curl -O https://mendel-linux.org/images/excelsior/eagle/excelsior-eagle-20201210233645.zip
unzip excelsior-eagle-20201210233645.zip
cd excelsior-eagle-20201210233645
bash enable_lk_fastboot.sh
echo "Now run flash.sh"
#bash flash.sh
