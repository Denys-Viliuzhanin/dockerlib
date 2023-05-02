#!/bin/bash

doctl compute firewall list --format "ID, Name" | grep "$1" | cut -c1-37