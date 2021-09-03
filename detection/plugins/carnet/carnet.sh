#!/bin/bash
FILE=/home/mendel/OSIDS/detection/plugins/carnet/carnet.jpg
while true; do
if [[ -f $FILE ]]; then
echo "Car Found..."
curl -X 'POST'   'https://api.carnet.ai/v2/mmg/detect?&region=NA'   -H 'accept: application/json'   -H 'api-key: 30ddb3bd-3453-44e5-bb9e-2b8f418fe0fe'   -H 'Content-Type: application/octet-stream' --data-binary @"$FILE" >> carnet.txt
#rm $FILE
sleep 5
else
echo "No Car Found"
sleep 10
fi
done
