#!/usr/bin/with-contenv bashio
# ==============================================================================
# Configures Vault
# ==============================================================================

declare certfile
declare keyfile

keyfile="/ssl/$(bashio::config 'keyfile')"
certfile="/ssl/$(bashio::config 'certfile')"
if bashio::fs.file_exists "${certfile}" \
  && bashio::fs.file_exists "${keyfile}";
then
  bashio::log.info "Certificates found: SSL is available"
  ssl="true"
else
  bashio::log.info "SSL is not enabled"
  ssl="false"
fi

# Generate vault configuration.
bashio::var.json \
  certfile "${certfile}" \
  keyfile "${keyfile}" \
  ssl "^${ssl}" \
  | tempio \
    -template /usr/share/tempio/vault.gtpl \
    -out /etc/vault/local.json

if [[ -f "/data/VAULT-UNSEAL-KEY" ]]; then
  jq ".ssl = ${ssl}|.unseal_key = \"$(cat /data/VAULT-UNSEAL-KEY)\"" /data/options.json \
    | tempio \
      -template /usr/share/tempio/vault-unseal.gtpl \
      -out /etc/vault-unseal.yaml
  chmod 600 /etc/vault-unseal.yaml
  chown vault:vault /etc/vault-unseal.yaml
fi
