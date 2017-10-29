#!/bin/bash

# To run this script, you need to do the following:
# (0) Save this script as "ut4-install.sh"
# (1) Open a terminal to the same locaction as this script.
# (2) run this command in the terminal:"sudo chmod 777 ut4-install.sh"
# (3) next, run this command:"./ut4-install.sh"
# (4) monitor the terminal window, it will ask for your SUDO password at some point.
# (5) when the script completes, you should be able to play Unreal Tournament 4
# (X) For updated releases, check: https://www.epicgames.com/unrealtournament/blog/

# Step 1: Download the file
wget "https://s3.amazonaws.com/unrealtournament/ShippedBuilds/%2B%2BUT%2BRelease-Next-CL-3525360/UnrealTournament-Client-XAN-3525360-Linux.zip"

# Step 2: Extract the files to a folder
mkdir /home/$USER/.UT4-Game
unzip Unreal* -d /home/$USER/.UT4-Game/

# Step 3: Fix file permissions
cd /home/$USER/.UT4-Game/LinuxNoEditor/Engine/Binaries/Linux/
sudo chmod +x UE4-Linux-Shipping

# Step 4: Launchable icons
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
sudo mv ut4.desktop /usr/share/applications/ut4.desktop

