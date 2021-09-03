#!/bin/bash
#runs on the pc
cd ~/
mkdir -p bin
export PATH=$PATH:$HOME/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
mkdir -p source && cd source
#this is the dev board mini flag
repo init -u https://coral.googlesource.com/manifest -m enterprise.xml
repo sync -j$(nproc)
sudo apt-get install qemu-user-static
sudo apt-get install docker.io
apt-get install build-essential qemu-user-static bc
source build/setup.sh
