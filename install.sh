#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $SCRIPTDIR

op_system=win

# Parameters
mode=$1
mode=${mode:-forge}
echo "Mode:    [$mode]"

version=$2
if [ "$mode" == "forge" ]; then
	version=${version:-1.16.4-35.1.4}
	version=${version:-1.16.5-36.0.0}
else
	echo "TODO 23645, aborting"
	exit 1
fi
echo "Version: [$version]"
echo

outDir=${version}-${mode}

rm -rf "$outDir" # fixme

echo "Prepare output directory $outDir"
if [ -e "$outDir" ]; then
	echo "$SCRIPTDIR/$outDir already exist. Delete it manually & start this script again."
	exit 1
fi
mkdir -p "$outDir"

# http://files.minecraftforge.net/
if [ "$mode" == "forge" ]; then
	cd "$outDir" >/dev/null
	curl --output 	forge-installer.jar   https://files.minecraftforge.net/maven/net/minecraftforge/forge/${version}/forge-${version}-installer.jar
	java -jar 		forge-installer.jar --installServer
	rm forge-installer.jar
	jarToRun=forge-${version}.jar
	javaParams="-Xms1G -Xmx1G -jar $jarToRun nogui pause"
elif [ "$mode" == "vanilla" ]; then
	cd "$outDir" >/dev/null
	curl --output 	forge-installer.jar   https://files.minecraftforge.net/maven/net/minecraftforge/forge/${version}/forge-${version}-installer.jar
	java -jar 		forge-installer.jar --installServer
	rm forge-installer.jar
	jarToRun=forge-${version}.jar
	javaParams="-Xms1G -Xmx1G -jar $jarToRun nogui pause"
fi

cd $SCRIPTDIR
echo "Creating start script..."
if [ $op_system == 'win' ]; then
	startScript=start-${outDir}.cmd
	(
		echo "@echo off"
		echo "pushd %~dp0\\${outDir}"
		echo " java $javaParams"
		echo "popd"
	) > $startScript
else
	echo "TODO 23545, aborting"
	exit 1
fi

echo "Starting the server first time..."
cmd.exe /c $startScript

#  eula
echo eula=true> $outDir/eula.txt

