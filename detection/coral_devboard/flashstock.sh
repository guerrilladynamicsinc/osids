#1/bin/bash
echo "Connect over USB OTG"
sleep 10
curl -O https://mendel-linux.org/images/enterprise/eagle/enterprise-eagle-20210518200035.zip
unzip enterprise-eagle-20210518200035.zip 
&& cd enterprise-eagle-20210518200035

bash flash.sh
