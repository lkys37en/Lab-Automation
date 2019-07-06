#!/bin/bash -e
echo "[+] Configuring Multi User Mode"
systemctl set-default multi-user.target

echo "[+] Creating directories..."
mkdir -p /opt/tools > /dev/null 2>&1
mkdir -p /opt/tools/wordlists > /dev/null 2>&1
mkdir -p /opt/tools/Powershell > /dev/null 2>&1
mkdir -p /opt/tools/Sysinternals > /dev/null 2>&1
mkdir -p /opt/tools/WebShells > /dev/null 2>&1
mkdir -p /opt/tools/CSharpTools > /dev/null 2>&1
mkdir -p /opt/tools/Potato > /dev/null 2>&1

echo "[+] Installing common tools"
export DEBIAN_FRONTEND=noninteractive > /dev/null 2>&1
apt-get remove python-pypcap  > /dev/null 2>&1
apt-get install -y python-libpcap python-ldap libpcap-dev libnetfilter-queue-dev golang wine winbind apt-transport-https sublime-text libgconf-2-4 krb5-user npm neo4j python3.7 python3.7-dev python3-pip libssl-dev libffi-dev python-dev build-essential libssl-dev libffi-dev python-dev enum4linux metasploit-framework > /dev/null 2>&1

echo "[+] Installing oh-my-zsh"
echo exit | sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" > /dev/null 2>&1

echo "[+] Making terminal beautiful"
cd /opt/utilities && git clone https://github.com/garabik/grc.git 
cd /opt/utilities/grc && ./install.sh 

echo "[+] Downloading and unpacking Sysinternals"
wget https://download.sysinternals.com/files/SysinternalsSuite.zip -O /opt/tools/Sysinternals  && unzip -d /opt/tools/Sysinternals/SysinternalsSuite.zip -d /opt/tools/Sysinternals/

echo "[+] Initializing Metasploit database"
msfdb init 

echo "[+] Cloning Tetanus"
cd /opt/tools && git clone https://github.com/secgroundzero/tetanus.git > /dev/null 2>&1

echo "[+] Cloning DAws"
cd /opt/tools/WebShells && git clone https://github.com/dotcppfile/DAws > /dev/null 2>&1

echo "[+] Cloning CACTUSTORCH"
cd /opt/tools && git clone https://github.com/vysec/CACTUSTORCH.git > /dev/null 2>&1

echo "[+] Cloning DotNetToJScript"
cd /opt/tools && git clone https://github.com/tyranid/DotNetToJScript.git > /dev/null 2>&1

echo "[+] Cloning Dirsearch"
cd /opt/tools && git clone https://github.com/maurosoria/dirsearch.git > /dev/null 2>&1

echo "[+] Cloning Windapsearch"
cd /opt/tools && git clone https://github.com/ropnop/windapsearch.git > /dev/null 2>&1

echo "[+] Cloning Responder"
cd /opt/tools && git clone https://github.com/lgandx/Responder.git > /dev/null 2>&1

echo "[+] Cloning SecLists wordlists"
cd /opt/tools/wordlists && git clone https://github.com/danielmiessler/SecLists.git > /dev/null 2>&1

echo "[+] Cloning Python Bloodhound"
cd /opt/tools/ && git clone https://github.com/fox-it/BloodHound.py.git > /dev/null 2>&1

echo "[+] Cloning Bloodhound"
cd /opt/tools/ && git clone https://github.com/BloodHoundAD/BloodHound.git > /dev/null 2>&1

echo "[+] Cloning SMBCrunch"
cd /opt/tools && git clone https://github.com/Raikia/SMBCrunch.git > /dev/null 2>&1

echo "[+] Cloning Unicorn"
cd /opt/tools && git clone https://github.com/trustedsec/unicorn.git > /dev/null 2>&1

echo "[+] Cloning Kerberos password spray scripts"
cd /opt/tools && git clone https://github.com/ropnop/kerberos_windows_scripts.git > /dev/null 2>&1

echo "[+] Cloning Invoke-Obfuscation"
cd /opt/tools/Powershell && git clone https://github.com/danielbohannon/Invoke-Obfuscation.git > /dev/null 2>&1

echo "[+] Cloning DomainPasswordSprayer"
cd /opt/tools/Powershell && git clone https://github.com/dafthack/DomainPasswordSpray.git > /dev/null 2>&1

echo "[+] Cloning Invoke-TheHash"
cd /opt/tools/Powershell && git clone https://github.com/Kevin-Robertson/Invoke-TheHash.git > /dev/null 2>&1

echo "[+] Cloning Inveigh"
cd /opt/tools/Powershell && git clone https://github.com/Kevin-Robertson/Inveigh.git > /dev/null 2>&1

echo "[+] Cloning LAPSToolKit"
cd /opt/tools/Powershell && git clone https://github.com/leoloobeek/LAPSToolkit.git > /dev/null 2>&1

echo "[+] Cloning MailSniper"
cd /opt/tools/Powershell && git clone https://github.com/dafthack/MailSniper.git > /dev/null 2>&1

echo "[+] Cloning Nishang scripts"
cd /opt/tools/Powershell && git clone https://github.com/samratashok/nishang.git > /dev/null 2>&1

echo "[+] Cloning Powersploit PowerView (dev branch)"
cd /opt/tools/Powershell && git clone https://github.com/PowershellMafia/PowerSploit.git 
cd /opt/tools/Powershell/PowerSploit && git checkout dev && git pull > /dev/null 2>&1

echo "[+] Cloning PowerUpSQL"
cd /opt/tools/Powershell && git clone https://github.com/NetSPI/PowerUpSQL.git > /dev/null 2>&1

echo "[+] Cloning RedTeamPowershellScripts"
cd /opt/tools/Powershell && git clone https://github.com/Mr-Un1k0d3r/RedTeamPowershellScripts.git > /dev/null 2>&1

echo "[+] Cloning SessionGopher"
cd /opt/tools/Powershell && git clone https://github.com/Arvanaghi/SessionGopher.git > /dev/null 2>&1

echo "[+] Cloning ADRecon"
cd /opt/tools/Powershell && git clone https://github.com/sense-of-security/ADRecon.git > /dev/null 2>&1

echo "[+] Cloning Grouper"
cd /opt/tools/Powershell && git clone https://github.com/l0ss/Grouper.git > /dev/null 2>&1

echo "[+] Cloning Lonely Potato"
cd /opt/tools/Potato && git clone https://github.com/decoder-it/lonelypotato.git > /dev/null 2>&1

echo "[+] Cloning Juicy Potato"
cd /opt/tools/Potato && git clone https://github.com/ohpe/juicy-potato.git > /dev/null 2>&1

echo "[+] Cloning EAP Hammer"
cd /opt/tools && git clone https://github.com/s0lst1c3/eaphammer.git > /dev/null 2>&1

echo "[+] Cloning PrivExchange"
cd /opt/tools && git clone https://github.com/dirkjanm/PrivExchange.git > /dev/null 2>&1

echo "[+] Installing Sublist3r"
cd /opt/tools && git clone https://github.com/aboul3la/Sublist3r.git > /dev/null 2>&1
cd /opt/tools/Sublist3r && pip install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing Sharpshooter"
cd /opt/tools && git clone https://github.com/mdsecactivebreach/SharpShooter.git > /dev/null 2>&1
cd /opt/tools/SharpShooter && pip install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing SprayingToolkit "
cd /opt/tools && git clone https://github.com/byt3bl33d3r/SprayingToolkit.git > /dev/null 2>&1
cd /opt/tools/SprayingToolkit && pip3 install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing Patator"
cd /opt/tools && git clone https://github.com/lanjelot/patator.git > /dev/null 2>&1
cd /opt/tools/patator && pip install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing PCredz"
cd /opt/tools && git clone https://github.com/lgandx/PCredz.git > /dev/null 2>&1

echo "[+] Installing SilentTrinity"
cd /opt/tools && git clone https://github.com/byt3bl33d3r/SILENTTRINITY
cd /opt/tools/SILENTTRINITY/Server && pip3 install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing jexboss"
cd /opt/tools && git clone https://github.com/joaomatosf/jexboss.git 
cd opt/tools/jexboss && pip install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing CME Bleeding Edge"
cd /opt/tools && git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec > /dev/null 2>&1
cd /opt/tools/CrackMapExec && pip install -r requirements.txt > /dev/null 2>&1
cd /opt/tools/CrackMapExec && python setup.py build  > /dev/null 2>&1
cd /opt/tools/CrackMapExec && python setup.py install > /dev/null 2>&1

echo "[+] Installing Impacket"
cd /opt/tools && git clone https://github.com/CoreSecurity/impacket.git
cd /opt/tools/impacket && pip install . > /dev/null 2>&1

echo "[+] Installing FingerPrinter"
cd /opt/tools && git clone https://github.com/erwanlr/Fingerprinter.git
cd /opt/tools/Fingerprinter.git && gem install bundler && bundle install > /dev/null 2>&1

echo "[+] Installing EyeWitness"
cd /opt/tools && git clone https://github.com/ChrisTruncer/EyeWitness.git > /dev/null 2>&1
cd /opt/tools/EyeWitness/setup && ./setup.sh > /dev/null 2>&1

echo "[+] Installing Empire"
cd /opt/tools && git clone https://github.com/EmpireProject/Empire.git > /dev/null 2>&1
cd /opt/tools/Empire/setup && echo -ne '\n' | ./install.sh > /dev/null 2>&1

echo "[+] Installing Koadic"
cd /opt/tools && git clone https://github.com/zerosum0x0/koadic.git > /dev/null 2>&1
cd /opt/tools/koadic && pip3 install -r requirements.txt > /dev/null 2>&1

echo "[+] Installing Ruler"
go get github.com/sensepost/ruler > /dev/null 2>&1
cd /root/go/src/github.com/sensepost/ruler && go build && go install > /dev/null 2>&1

echo "[+] Installing Gobuster"
go get github.com/OJ/gobuster > /dev/null 2>&1
cd /root/go/src/github.com/OJ/gobuster && go build && go install > /dev/null 2>&1

echo "[+] Tuning file system..."
tune2fs -m 2 /dev/sda1  > /dev/null 2>&1

echo "[+] Assigning services to start on boot..."
update-rc.d postgresql enable
update-rc.d openvpn enable
update-rc.d neo4j enable