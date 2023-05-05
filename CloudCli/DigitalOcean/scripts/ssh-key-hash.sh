#!/bin/bash

doctl compute ssh-key list --format "ID, FingerPrint" | grep "$1" | cut -c13-64
