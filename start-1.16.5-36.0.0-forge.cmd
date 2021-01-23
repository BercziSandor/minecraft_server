@echo off
pushd %~dp0\1.16.5-36.0.0-forge
 java -Xms1G -Xmx1G -jar forge-1.16.5-36.0.0.jar nogui pause
popd
