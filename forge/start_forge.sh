#!/bin/bash
set -e

version=1.16.4-35.1.4

# **************************************************************

echo "Checking Java..."
which java || sudo apt install default-jre -y
# overwolf

# https://minecraft.gamepedia.com/Tutorials/Setting_up_a_Minecraft_Forge_server

installer_jar_name=forge-${version}-installer.jar

echo "Downloading installer..."
curl -C - -o ${installer_jar_name} https://files.minecraftforge.net/maven/net/minecraftforge/forge/${version}/${installer_jar_name}

echo "Installing Forge server..."
java -jar $installer_jar_name --installServer

echo "Starting Forge server..."
java -Xmx1024M -Xms512M 	-jar forge-${version}.jar --nogui