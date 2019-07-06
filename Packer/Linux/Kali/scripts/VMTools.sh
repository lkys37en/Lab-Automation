#!/bin/bash
echo "[+] Installng VMWare Tools"
apt-get -y install linux-headers-`uname -r` > /dev/null 2>&1
apt-get install -y open-vm-tools > /dev/null 2>&1