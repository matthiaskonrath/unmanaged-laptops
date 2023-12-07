#!/bin/bash
# Author: Matthias Konrath
# Email:  matthias@inet-sec.at

print_seperator () {
  echo ""
  echo "### - ### - ### - ### - ### - ###"
}

print_seperator
echo "[04] computer name:"
hostname

print_seperator
echo "[05] domain name:"
dsconfigad -show | grep -A2 -i "Active Directory Forest"
echo "[05] domain info:"
dsconfigad -show

print_seperator
echo "[06] NTP status:"
sudo /usr/sbin/systemsetup -getusingnetworktime
sudo /usr/sbin/systemsetup -getnetworktimeserver

print_seperator
echo "[13] last usage:"
last

print_seperator
echo "[17, 19] last updates:"
softwareupdate --history

print_seperator
echo "[18] OS version:"
uname -ra
echo "[18] available updates:"
softwareupdate -l

print_seperator
echo "[21]: wifi and bluetooth settings"
networksetup -getairportpower en0
networksetup -listallhardwareports
system_profiler SPBluetoothDataType

print_seperator
echo "[25 + 26] installed programs inkl. versions:"
system_profiler SPApplicationsDataType
brew list --versions

print_seperator
echo "[28] firewall status:"
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
/usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode

print_seperator
echo "[29] firewall rules:"
/usr/libexec/ApplicationFirewall/socketfilterfw --listapps

print_seperator
echo "[33] users:"
dscl . list /Users | grep -v "^_"

print_seperator
echo "[34] admin users:"
dscacheutil -q group -a name admin
dscacheutil -q group -a name staff

print_seperator
echo "[39] automatic updates:"
softwareupdate --schedule

print_seperator
echo "[40] screensaver status:"
sysadminctl -screenLock status

print_seperator
echo "[41] screensaver delay:"
defaults -currentHost read com.apple.screensaver idleTime

print_seperator
echo "[42, 43, 44] FDE:"
fdesetup status

print_seperator
echo "[46] Secure boot:"
csrutil status
spctl --status
kextstat | grep -v com.apple
