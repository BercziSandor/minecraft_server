@echo off
START "" /WAIT CMD /C "echo IP of the server: & curl -s ipinfo.io/ip & echo. & pause"
pushd %~dp0\1.16.5-36.0.45-forge
 java -Xms1G -Xmx1G -jar forge-1.16.5-36.0.45.jar nogui pause
popd
