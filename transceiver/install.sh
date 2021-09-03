sudo apt-get install webhook libttspico-utils libopenal-dev libopus-dev libasound2-dev git ffmpeg mplayer screen pkg-config


adduser --disabled-password --disabled-login --gecos "" talkkonnect
usermod -a -G cdrom,audio,video,plugdev,users,dialout,dip,input,gpio talkkonnect


cd /usr/local

wget https://golang.org/dl/go1.15.6.linux-arm64.tar.gz

tar -zxvf go1.15.6.linux-arm64.tar.gz

nano ~/.bashrc

export PATH=$PATH:/usr/local/go/bin

export GOPATH=/home/talkkonnect/gocode

export GOBIN=/home/talkkonnect/bin

export GO111MODULE="auto"

alias tk='cd /home/talkkonnect/gocode/src/github.com/talkkonnect/talkkonnect/'

cd /home/talkkonnect
mkdir /home/talkkonnect/gocode
mkdir /home/talkkonnect/bin
export GOPATH=/home/talkkonnect/gocode
export GOBIN=/home/talkkonnect/bin 
cd $GOPATH 
go get -v github.com/talkkonnect/talkkonnect 
cd $GOPATH/src/github.com/talkkonnect/talkkonnect
echo "MODIFY YOUR CONFIG FILE - "
sleep 5
nano /home/talkkonnect/gocode/src/github.com/talkkonnect/talkkonnect/talkkonnect.xml

go build -o /home/talkkonnect/bin/talkkonnect cmd/talkkonnect/main.go


