
curl.exe -C - -o minecraft_server.jar https://launcher.mojang.com/v1/objects/35139deedbd5182953cf1caa23835da59ca3d7cd/server.jar
java -Xmx1024M -Xms512M 	-jar minecraft_server.jar --nogui
rem java -Xmx1G 			-jar minecraft_server.jar --port 1337 --nogui --world cold

goto:eof
--bonusChest		If a bonus chest should be generated, when the world is first generated.
--demo			If the server is in demo mode. (Shows the players a demo pop-up, no further implications?)
--eraseCache		Erases the lighting caches, etc. Same option as when optimizing single player worlds.
--forceUpgrade		Forces upgrade on all the chunks, such that the data version of all chunks matches the current server version (same as with sp worlds).
--help			Shows this help.
--initSettings		Initializes 'server.properties' and 'eula.txt', then quits.
--nogui			Doesn't open the GUI when launching the server.
--port <Integer>	Which port to listen on, overrides the server.properties value. (default: -1)
--safeMode		Loads level with vanilla datapack only.
--serverId <String>	Gives an ID to the server. (??)
--singleplayer <String>	Runs the server in offline mode (unknown where <String> is used for, probably used internally by mojang?)
--universe <String>	The folder in which to look for world folders. (default: .)
--world <String>	The name of the world folder in which the level.dat resides.



