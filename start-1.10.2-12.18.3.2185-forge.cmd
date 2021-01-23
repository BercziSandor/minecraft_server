@echo off
echo *****************************
echo The ip of the server:
START "" /WAIT CMD /C "echo IP of the server: & curl -s ipinfo.io/ip & echo. & pause"
echo 
echo *****************************
pushd %~dp0\1.10.2-12.18.3.2185-forge
 java -Xms1G -Xmx1G -jar forge-1.10.2-12.18.3.2185-universal.jar nogui pause
popd
