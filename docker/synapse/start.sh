#!/bin/sh

set -o errexit
set -o nounset

#Get the value of the POSTGRES_URL environment variable
url=$(echo $DATABASE_URL)
# echo ${url}

# Split the URL into parts
protocol=$(echo $url | awk -F: '{print $1}')
user_pass=$(echo $url | awk -F@ '{print $1}' | awk -F// '{print $2}')
user=$(echo $user_pass | awk -F: '{print $1}')
password=$(echo $user_pass | awk -F: '{print $2}')
host=$(echo $url | awk -F@ '{print $2}' | awk -F/ '{print $1}')
database=$(echo $url | awk -F/ '{print $4}')

# Store the extracted parts in separate variables to be passed into the homeserver.yaml config
POSTGRES_HOST=`echo $host | awk -F: '{print $1}'`
POSTGRES_USER=$user
POSTGRES_PASSWORD=$password
POSTGRES_NAME=$database


envsubst '${FORM_SECRET},
          ${REGISTRATION_SHARED_SECRET},
          ${MACAROON_SECRET_KEY}' < /data/homeserver.yaml > /data/homeserver.yaml.template
envsubst '${POSTGRES_USER},
          ${POSTGRES_PASSWORD},
          ${POSTGRES_NAME},
          ${POSTGRES_HOST}' < /data/homeserver.yaml.template > /data/homeserver.yaml
# cat /data/homeserver.yaml

python3 -m synapse.app.homeserver --config-path /data/homeserver.yaml
