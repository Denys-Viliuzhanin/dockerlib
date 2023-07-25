#!/bin/bash

output_file=$1

gpg --batch --yes --symmetric --armor --output "$output_file" <&0
