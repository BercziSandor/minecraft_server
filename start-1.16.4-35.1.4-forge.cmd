@echo off
pushd %~dp0\1.16.4-35.1.4-forge
 java -Xms1G -Xmx1G -jar forge-1.16.4-35.1.4.jar nogui pause
popd
