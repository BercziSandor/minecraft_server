@echo off
pushd %~dp0\1.16.5-vanilla
 java -Xms1G -Xmx1G -jar vanilla-1.16.5.jar nogui pause
popd
