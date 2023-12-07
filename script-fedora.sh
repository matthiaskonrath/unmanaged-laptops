#!/bin/bash
# Author: Matthias Konrath
# Email:  matthias@inet-sec.at

print_seperator () {
  echo ""
  echo "### - ### - ### - ### - ### - ###"
}

print_seperator
echo "[04] computer name:"
hostname --fqdn

print_seperator
echo "[05] domain name:"
kinit -k host/$(hostname -f)
echo "[05] domain info:"
realm list

print_seperator
echo "[06] NTP status:"
systemctl status chronyd | grep Active: | sed -e 's/^[ \t]*//'

print_seperator
echo "[13] last usage:"
last

print_seperator
echo "[17] last updates:"
yum history

print_seperator
echo "[18] OS version:"
uname -ra
echo "[18] available updates:"
dnf check-update

print_seperator
echo "[19] last update:"
dnf history | grep " update"

print_seperator
echo "[21]: wifi and bluetooth settings"
nmcli
hciconfig

print_seperator
echo "[22] known wifi networks:"
nmcli -f TYPE,TIMESTAMP,NAME con show | gawk '$1 == "wifi" { nn = ""; for (i = 3; i <= NF; i++) nn = nn $i " "; printf "%s : %s\n", nn, strftime("%d-%m-%Y %H:%M",$2)}'

print_seperator
echo "[23 + 24] public wifi networks or weak security:"
nmcli -f TYPE,TIMESTAMP,NAME con show | grep wifi | awk '{ s = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s}' | awk '{$1=$1};1' |xargs -I{} nmcli connection show {} -s

print_seperator
echo "[25 + 26] installed programs inkl. versions:"
dnf list

print_seperator
echo "[28] firewall status:"
systemctl status firewalld | grep Active: | sed -e 's/^[ \t]*//'

print_seperator
echo "[29] firewall rules:"
firewall-cmd --list-all

print_seperator
echo "[33] users:"
cat /etc/passwd

print_seperator
echo "[34] groups (admin users):"
cat /etc/group

print_seperator
echo "[39] automatic updates:"
systemctl list-timers 'dnf-*'

print_seperator
echo "[40] screensaver status:"
gsettings get org.gnome.desktop.screensaver lock-enabled

print_seperator
echo "[41] screensaver delay:"
gsettings get org.gnome.desktop.screensaver lock-delay

print_seperator
echo "[42, 43, 44] FDE:"
lsblk
blkid

print_seperator
echo "[46] Secure boot:"
mokutil --sb-state
