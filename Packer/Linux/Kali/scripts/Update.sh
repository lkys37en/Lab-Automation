#!/bin/bash
 echo "[+] Installing VSCode"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https > /dev/null 2>&1 
sudo apt-get update > /dev/null 2>&1
sudo apt-get install code > /dev/null 2>&1

echo "[+] Adding Neo4j Repo"
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add - > /dev/null 2>&1
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list  > /dev/null 2>&1

echo "[+] Updating repo"
apt-get update -y > /dev/null 2>&1

echo "[+] Performing distribution upgrade"
DEBIAN_FRONTEND=noninteractive apt-get -fuy -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade > /dev/null 2>&1