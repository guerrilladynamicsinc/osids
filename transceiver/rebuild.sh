export PATH=$PATH:/usr/local/go/bin

export GOPATH=/home/talkkonnect/gocode

export GOBIN=/home/talkkonnect/bin

export GO111MODULE="auto"

alias tk='cd /home/talkkonnect/gocode/src/github.com/talkkonnect/talkkonnect/'


cd /home/talkkonnect/gocode/src/github.com/talkkonnect/talkkonnect/
go build -o /home/talkkonnect/bin/talkkonnect cmd/talkkonnect/main.go
screen -dmS talkkonnect-radio /home/talkkonnect/talkkonnect-run && sleep 10 && curl http://localhost:8080/?command=StartTransmitting &
