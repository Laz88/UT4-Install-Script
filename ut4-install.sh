#!/bin/bash

##########################
# README FOR NEW USERS   #
##########################
#
# You need to enter these commands in an Ubuntu terminal:
#
# 	wget https://raw.githubusercontent.com/Laz88/UT4-Install-Script/master/ut4-install.sh
# 	chmod +x ut4-install.sh
# 	./ut4-install.sh
#
# Alternatively, you can string these together as one long command:
#
#	wget https://raw.githubusercontent.com/Laz88/UT4-Install-Script/master/ut4-install.sh && chmod +x ut4-install.sh && ./ut4-install.sh
#
# A more elegant one line command:
#
# 	bash <(wget -O - https://raw.githubusercontent.com/Laz88/UT4-Install-Script/master/ut4-install.sh)
#
##########################
# SCRIPT BEGINS HERE     #
##########################

# Step 0: verify the user is not root (or else the script will fail)

if [ "$USER" == root ]; then
	echo "[USER check] = Failed"
	echo "Error -- this script cannot be executed with sudo. Try ./ instead."
	echo "Exiting..."
	exit
else
	echo "[USER check] = $USER"
fi

DOWNLOADED_FILE=`mktemp`
INSTALL_FOLDER="${HOME}/.UT4-Game"

# Step 1: Download the file
wget https://s3.amazonaws.com/unrealtournament/ShippedBuilds/%2B%2BUT%2BRelease-Next-CL-3525360/UnrealTournament-Client-XAN-3525360-Linux.zip -O "${DOWNLOADED_FILE}"

# Step 2: Extract the files to a folder
mkdir "${INSTALL_FOLDER}"
unzip "${DOWNLOADED_FILE}" -d "${INSTALL_FOLDER}"

# Step 3: Cleanup the download to save space
rm "${DOWNLOADED_FILE}"

# Step 4: Fix file permissions
cd "${INSTALL_FOLDER}/LinuxNoEditor/Engine/Binaries/Linux/"
chmod +x UE4-Linux-Shipping

# Step 5: Launchable icons
cat <<EOF > ut4.desktop
[Desktop Entry]
Name=Unreal Tournament
Exec=${INSTALL_FOLDER}/LinuxNoEditor/Engine/Binaries/Linux/UE4-Linux-Shipping UnrealTournament
Terminal=false
Type=Application
Icon=transmission
Categories=GTK;GNOME;Utility;
EOF
chmod +x ut4.desktop
cp ut4.desktop "${HOME}/Desktop/ut4.desktop"
sudo cp ut4.desktop /usr/share/applications/ut4.desktop

# Step 6: Create an Uninstaller
echo "alias ut4-uninstall='rm -Rf ${INSTALL_FOLDER} && rm ${HOME}/Desktop/ut4.desktop && sudo rm /usr/share/applications/ut4.desktop'" >> ~/.bash_aliases && source ~/.bash_aliases

echo "To uninstall UT4, type ut4-uninstall in a terminal"

# Step 7: Unlock maps
xdg-open https://www.epicgames.com/unrealtournament/forums/mapunlock
