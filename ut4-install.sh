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

# Step 1: Download the file
cd ~/Downloads/
mkdir ut4download
cd ut4download
wget https://s3.amazonaws.com/unrealtournament/ShippedBuilds/%2B%2BUT%2BRelease-Next-CL-3525360/UnrealTournament-Client-XAN-3525360-Linux.zip

# Step 2: Extract the files to a folder
mkdir /home/$USER/.UT4-Game
unzip Unreal* -d /home/$USER/.UT4-Game/

# Step 3: Cleanup the download to save space
rm Unreal*
cd ..
rmdir ut4download

# Step 4: Fix file permissions
cd /home/$USER/.UT4-Game/LinuxNoEditor/Engine/Binaries/Linux/
sudo chmod +x UE4-Linux-Shipping

# Step 5: Launchable icons
touch ut4.desktop
echo "[Desktop Entry]" >> ut4.desktop
echo "Name=Unreal Tournament" >> ut4.desktop
echo "Exec=/home/$USER/.UT4-Game/LinuxNoEditor/Engine/Binaries/Linux/UE4-Linux-Shipping UnrealTournament" >> ut4.desktop
echo "Terminal=false" >> ut4.desktop
echo "Type=Application" >> ut4.desktop
echo "Icon=transmission" >> ut4.desktop
echo "Categories=GTK;GNOME;Utility;" >> ut4.desktop
sudo chmod +x ut4.desktop
cp ut4.desktop /home/$USER/Desktop/ut4.desktop
sudo cp ut4.desktop /usr/share/applications/ut4.desktop

# Step 6: Create an Uninstaller
echo "alias ut4-uninstall='rm -rf /home/$USER/.UT4-Game/ && rm /home/$USER/Desktop/ut4.desktop && sudo rm /usr/share/applications/ut4.desktop'" >> ~/.bash_aliases && source ~/.bash_aliases

echo "To uninstall UT4, type ut4-uninstall in a terminal"

# Step 7: Unlock maps
xdg-open https://www.epicgames.com/unrealtournament/forums/mapunlock
