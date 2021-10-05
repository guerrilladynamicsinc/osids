#!/bin/bash
   (
python3 << EOF
import base64
import json
import requests
markdown = f"![Image]($3)"
post_data = {
    "title": "$1",
    "message": markdown,
    "priority": 5,
    "extras": {
        "client::display": {
            "contentType": "text/markdown"
        }
    }
}
print(json.dumps(post_data))
EOF
) | curl  -H "Content-Type: application/json" -H "X-Gotify-Key: $2" -X POST --data-binary @- "$4"/message
