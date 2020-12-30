rem https://minecraft.gamepedia.com/Tutorials/Setting_up_a_Minecraft_Forge_server
set version=1.16.4-35.1.4
set installer_jar_name=forge-%version%-installer.jar

echo Downloading installer...
curl.exe -C - -o %installer_jar_name% https://files.minecraftforge.net/maven/net/minecraftforge/forge/%version%/%installer_jar_name%

echo Installing forge server...
java -jar %installer_jar_name% --installServer
rem del %installer_jar_name%

java -Xmx1024M -Xms512M 	-jar forge-%version%.jar --nogui