#!/bin/sh

set -o errexit
set -o nounset

envsubst '${FORM_SECRET},
          ${REGISTRATION_SHARED_SECRET},
          ${MACAROON_SECRET_KEY},
          ${POSTGRES_USER},
          ${POSTGRES_PASSWORD},
          ${DB_NAME},
          ${DB_HOST}' < /data/homeserver.yaml > /data/homeserver.yaml.template
cat /data/homeserver.yaml.template
mv /data/homeserver.yaml.template /data/homeserver.yaml
python3 -m synapse.app.homeserver --config-path /data/homeserver.yaml
