@echo off
pushd %~dp0\1.16.5-428-paper
 java -Xms1G -Xmx1G -jar paper-1.16.5-428.jar nogui pause
popd
