#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
else
	cd /opt/; sudo git clone "https://github.com/sahildari/R3CON"; cd R3CON; sudo chmod +x *.sh
fi
