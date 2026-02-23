#!/bin/bash

if [[ -z "$1" ]]; then
   echo "run this with your domain as argument."
   echo "bash setup.sh yourdomain.tld"
   exit
fi

STAMP=../continuwuity-$1-$(date +%s)

cp -r continuwuity-skeleton $STAMP

find $STAMP -type f -exec sed -i 's/yourdomain.tld/'"$1"'/g' {} \;
KEYS=$(sudo docker run --rm livekit/livekit-server:latest generate-keys | cut -d ' ' -f 4)
LIVEKIT_KEY=$(echo $KEYS | cut -d ' ' -f 1)
LIVEKIT_SECRET=$(echo $KEYS | cut -d ' ' -f 2)
find $STAMP -type f -exec sed -i 's/xxxxxxxxxxxxxxx/'"$LIVEKIT_KEY"'/g' {} \;
find $STAMP -type f -exec sed -i 's/zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz/'"$LIVEKIT_SECRET"'/g' {} \;
find $STAMP -type f -exec sed -i 's/yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy/'"$(openssl rand -hex 32)"'/g' {} \;

echo "your generated configuration is in the $STAMP folder."
echo "do you want to start it now? enter 'yes'."
read confirmation
if [[ $confirmation = "yes" ]]; then
   echo "starting the server using docker compose..."
   cd $STAMP
   docker compose up -d
fi
