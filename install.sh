#!/bin/bash
set -e



SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $SCRIPTDIR

op_system=win
# Forge: http://files.minecraftforge.net/
# Paper: https://papermc.io/


# Parameters
mode=$1
mode=${mode:-paper}
echo "Mode:    [$mode]"

version=$2
if [ "$mode" == "forge" ]; then
	version=1.16.4
	rel=35.1.4
	# version=${version:-1.16.4-35.1.4}
	# version=${version:-1.16.5-36.0.0}
	installerLink=https://files.minecraftforge.net/maven/net/minecraftforge/forge/${version}-${rev}/forge-${version}-${rev}-installer.jar
	version=${version}-${rev}
elif [ "$mode" == "paper" ]; then
	version=1.16.5
	rev=428
	installerLink=https://papermc.io/api/v2/projects/paper/versions/${version}/builds/${rev}/downloads/paper-${version}-${rev}.jar
	version=${version}-${rev}
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

if [ "$mode" == "forge" ]; then
	cd "$outDir" >/dev/null
	curl --output 	installer.jar   $installerLink
	java -jar 		installer.jar --installServer
	rm installer.jar
	javaParams="-Xms1G -Xmx1G -jar forge-${version}.jar nogui pause"

elif [ "$mode" == "paper" ]; then
	cd "$outDir" >/dev/null
	curl --output 	paper-${version}.jar   $installerLink
	javaParams="-Xms1G -Xmx1G -jar paper-${version}.jar nogui pause"

elif [ "$mode" == "vanilla" ]; then
	echo "TODO 23s545, aborting"
	exit 1
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

