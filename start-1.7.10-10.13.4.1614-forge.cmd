@echo off
START "" /WAIT CMD /C "echo IP of the server: & curl -s ipinfo.io/ip & echo. & pause"
pushd %~dp0\1.7.10-10.13.4.1614-forge
 java -Xms1G -Xmx1G -jar forge-1.7.10-10.13.4.1614-1.7.10-universal.jar nogui pause
popd
