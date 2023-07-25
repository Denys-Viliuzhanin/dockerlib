#!/bin/bash

input_file=$1

$(gpg --batch --yes --decrypt "$input_file") > &1
