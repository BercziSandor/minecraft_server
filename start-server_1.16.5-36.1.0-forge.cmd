@echo off
START "" /WAIT CMD /C "echo IP of the server: & curl -s ipinfo.io/ip & echo. & pause"
pushd %~dp0\server_1.16.5-36.1.0-forge
 java -Xms1G -Xmx1G -jar forge-1.16.5-36.1.0.jar nogui pause
popd
