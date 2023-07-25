#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

cp "/app/digitalocean-cli/templates/setup.droplet.template.sh" "./$1.setup.droplet.sh"

cp "/app/digitalocean-cli/templates/droplet.template.sh" "./$1.droplet.sh"

nano "./$1.droplet.sh"