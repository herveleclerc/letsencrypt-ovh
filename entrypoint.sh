#!/bin/bash
# Exit immediately on errors:
set -e

# Handle undefined variables as error:
set -u

# Debugging:
#set -x

server() {
  if [ "${1}" = "true" ]; then
    echo 'https://acme-staging.api.letsencrypt.org/directory'
  else
    echo 'https://acme-v01.api.letsencrypt.org/directory'
  fi
}

exec lego \
--accept-tos \
--dns=ovh \
--email="${EMAIL-hostmaster@${DOMAIN}}" \
--server="$(server "${STAGING:-false}")" \
--domains="${DOMAIN}" \
--key-type=rsa4096 \
--path '/target' \
"${@}"
