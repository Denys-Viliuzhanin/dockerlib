#!/bin/bash

export WORKSPACE_PATH=/workspace
export APP_PATH=/app/digitalocean-cli
export UTILS_PATH=/$APP_PATH/utils
export VAULT_PATH=/tmp/vault

export VAULT_PASSWORD=""
export VAULT_STORAGE_PATH=$WORKSPACE_PATH/.vault
export VAULT_STORAGE_LATEST_VERSION_PATH=$VAULT_STORAGE_PATH/latest
export VAULT_STORAGE_PREVIOUS_VERSION_PATH=$VAULT_STORAGE_PATH/previous


$APP_PATH/vault/vault-init.sh

/bin/bash