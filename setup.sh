#!/bin/bash

if [[ -z "$1" ]]; then
   echo "run this with your domain as argument."
   echo "bash setup.sh yourdomain.tld"
   exit
fi

find ./continuwuity -type f -exec sed -i 's/yourdomain.tld/'"$1"'/g' {} \;

KEYS=$(sudo docker run --rm livekit/livekit-server:latest generate-keys | cut -d ' ' -f 4)

LIVEKIT_KEY=$(echo $KEYS | cut -d ' ' -f 1)
LIVEKIT_SECRET=$(echo $KEYS | cut -d ' ' -f 2)

find ./continuwuity -type f -exec sed -i 's/xxxxxxxxxxxxxxx/'"$LIVEKIT_KEY"'/g' {} \;
find ./continuwuity -type f -exec sed -i 's/zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz/'"$LIVEKIT_SECRET"'/g' {} \;
