#!/bin/bash -e
echo "[+] Updating repo"
sudo apt-get -y update

echo "[+] Performing distribution upgrade"
sudo DEBIAN_FRONTEND=noninteractive apt-get -fuy -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

echo "[+] Allowing Root login after update"
sed -i "s/without-password/yes/" /etc/ssh/sshd_config