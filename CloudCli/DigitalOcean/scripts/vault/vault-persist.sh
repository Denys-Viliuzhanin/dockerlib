#!/bin/bash



if [[ ! -f "/tmp/vault.pwd" ]]; then
    echo -n Vault Password: 
    read -s VAULT_PASSWORD
    echo

    echo $VAULT_PASSWORD >> /tmp/vault.pwd
else
    VAULT_PASSWORD=$(cat /tmp/vault.pwd)
fi

VAULT_STORAGE_NEW="$VAULT_STORAGE_PATH/$(date +%s)"



if [[ ! -d "$VAULT_STORAGE_PATH" ]]; then
    mkdir $VAULT_STORAGE_PATH
fi

echo $VAULT_STORAGE_NEW > $VAULT_PATH/versions

zip -q -r --encrypt -P "$VAULT_PASSWORD" "$VAULT_STORAGE_NEW" "$VAULT_PATH"

if [[ -f "$VAULT_STORAGE_LATEST_VERSION_PATH" ]]; then
    cat $VAULT_STORAGE_LATEST_VERSION_PATH >> $VAULT_STORAGE_PREVIOUS_VERSION_PATH
fi

cat "$VAULT_STORAGE_NEW.zip" >> $VAULT_STORAGE_LATEST_VERSION_PATH


