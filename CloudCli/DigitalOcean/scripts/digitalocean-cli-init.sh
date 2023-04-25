#!/bin/bash

echo "Initialization  "



# Set the directory where the links will be created
link_dir="/usr/local/bin"

# Set the directory containing the files to link to
source_dir="/app/digitalocean-cli"

# Loop through each file in the source directory that ends with .sh
for file in "${source_dir}"/*.sh; do

  # Get the file name without the path
  file_name=$(basename "${file}" .sh)

  # Create the symbolic link in the link directory
  ln -s "${file}" "${link_dir}/${file_name}"

done