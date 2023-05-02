#!/bin/bash



ID=$(firewall-id "fr-$1-in-allow-ssh")

doctl compute firewall delete $ID