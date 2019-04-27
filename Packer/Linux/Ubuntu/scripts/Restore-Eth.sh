echo "[+] Setting eth0 to DHCP"
echo auto eth0 >> /etc/network/interfaces
echo iface eth0 inet dhcp >> /etc/network/interfaces

echo "[+] Modifying grub to supprt old eth interface naming"
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg