#!/bin/bash

doctl compute ssh-key list --format "ID, Name" | grep "$1" | cut -c1-8
