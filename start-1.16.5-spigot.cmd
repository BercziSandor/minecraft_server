@echo off
pushd %~dp0\1.16.5-spigot
 java -Xms1G -Xmx1G -jar spigot-1.16.5.jar nogui pause
popd
