#!/bin/bash
appstoinstall="intel-microcode p7zip-full unzip zip curl neofetch nmap net-tools bluefish bluefish-data bluefish-plugins figlet vlc htop git wget ufw gimp rhythmbox lynis steghide python3-psutil bleachbit apt-transport-https debian-keyring rkhunter debsums tlp rsyslog mate-menu mate-desktop-environment-extras"
appstoremove="nano exim4 exim4-base exim4-config exim4-daemon-light"
firewall="wlp0s20f3 "

#set up firewall
ufw enable
ufw logging on
ufw logging low
ufw default deny incoming
ufw default deny forward
ufw default deny outgoing
ufw allow out on $firewall  to 45.90.28.189 proto udp port 53
ufw allow out on $firewall  to 45.90.30.189 proto udp port 53
# ufw allow out on $firewall  to 1.1.1.1 proto udp port 53
# ufw allow out on $firewall  to 1.0.0.1 proto udp port 53
ufw allow out on $firewall  to any proto tcp port 80
ufw allow out on $firewall to any proto tcp port 443
ufw reload
ufw status verbose

# Disable services
systemctl disable bluetooth
systemctl disable avahi-daemon
systemctl disable cups-browsed
apt-get autoremove cups-daemon
apt-get purge avahi-daemon

# Download update file

wget -cO - https://raw.githubusercontent.com/wfbutler76/Bash/master/debbaseupdate > update

# Set permissions
chmod u+x update

# Run Update
sh update

# Download Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

apt-get update

apt-get install brave-browser

# Download discord
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb

sudo dpkg -i discord.deb

# Install apps
apt-get install $appstoinstall

# Remove unneeded apps
apt-get remove $appstoremove

# Set File Permissions
chmod 0444 /usr/bin/as
chmod 0444 /usr/bin/g++
chmod 0444 /usr/bin/gcc
chmod 0440 /etc/sudoers
chmod 0700 /etc/cups/cupsd.conf
chmod 600 /etc/crontab
chmod 700 /etc/cron.d
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly

# Delete exim4 files
rm -r /var/log/exim4/

exit 0