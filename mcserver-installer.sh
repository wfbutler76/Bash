#!/usr/bin/bash
#
#
minecraft=" wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar"

required_pkg="wget"
pkg_ok=$(dpkg-query -W --showformat='${Status}\n' $required_pkg|grep "ok installed")
echo Checking for $required_pkg $pkg_ok
if [ "" = "$pkg_ok" ]; then
  echo "No $required_pkg Setting up $required_pkg"
  sudo apt-get --yes install $required_pkgG
fi

# Create minecraft server directory
mkdir -p minecraft && cd minecraft

#Create eula file
touch eula.txt

echo "eula=true" >> eula.txt

# Download server file
wget $minecraft

# Create minecraft server start file
touch startmc.sh

# Set permisions
chmod u+x startmc.sh

#edit minecraft server file
echo "#!/usr/bin/bash" >> startmc.sh

echo "# set memory manually" >> startmc.sh

echo "# java -Xmx1024M -Xms1024M -jar server.jar nogui" >> startmc.sh

echo "# Defualt memory " >> startmc.sh

echo "java -jar server.jar nogui" >> startmc.sh

# Create minecraft server update file
touch updatemc.sh

# Set permisions
chmod u+x updatemc.sh

echo "#!/usr/bin/bash" >> updatemc.sh

echo "rm server.jar" >> updatemc.sh

echo "# Download server file" >> updatemc.sh

echo "$minecraft" >> updatemc.sh

echo "sh startmc.sh" >> updatemc.sh

sh startmc.sh

exit 0