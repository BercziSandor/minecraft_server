#!/bin/bash
set -e

java_memory_options="-Xms1G -Xmx1G"


SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $SCRIPTDIR

op_system=win


# Parameters
mode=$1
mode=${mode:-forge}
echo "Mode:    [$mode]"

version=$2
version=${version:-1.16.5}

if [ "$mode" == "forge" ]; then
    if [ "$version" == "1.16.5" ]; then
        rev=36.0.0
    elif [ "$version" == "1.10" ]; then
        # https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.10.2-12.18.3.2185/forge-1.10.2-12.18.3.2185-installer.jar
        version=1.10.2
        rev=12.18.3.2185
    else
        echo "This version is not supported."
        exit 1
    fi
    # version=${version:-1.16.4-35.1.4}
    # version=${version:-1.16.5-36.0.0}
    echo "Forge site: http://files.minecraftforge.net/"
    installerLink=https://files.minecraftforge.net/maven/net/minecraftforge/forge/${version}-${rev}/forge-${version}-${rev}-installer.jar
    version=${version}-${rev}

elif [ "$mode" == "paper" ]; then
    rev=428
    echo "Paper site: https://papermc.io/"
    installerLink=https://papermc.io/api/v2/projects/paper/versions/${version}/builds/${rev}/downloads/paper-${version}-${rev}.jar
    version=${version}-${rev}

elif [ "$mode" == "spigot" ]; then
    echo "Spigot site: https://www.spigotmc.org"
    installerLink=https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

elif [ "$mode" == "vanilla" ]; then
    # See: https://www.minecraft.net/en-us/download/server/
    installerLink=https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar
else
    echo "Invalid mode: $mode, aborting"
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



cd "$outDir" >/dev/null
if [ "$mode" == "forge" ]; then
    curl --output   installer.jar           $installerLink
    [ -e mods ] || mkdir mods
    java -jar       installer.jar --installServer
    rm installer.jar
elif [ "$mode" == "paper" ]; then
    curl --output   ${mode}-${version}.jar  $installerLink
elif [ "$mode" == "vanilla" ]; then
    curl --output   ${mode}-${version}.jar  $installerLink
elif [ "$mode" == "spigot" ]; then
    curl --output   BuildTools.jar          $installerLink
    # git config --global --unset core.autocrlf
    java -jar       BuildTools.jar --rev $version
else
    exit 1
fi
javaParams="$java_memory_options -jar $(ls ${mode}*.jar) nogui pause"

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
if [ $op_system == 'win' ]; then
    cmd.exe /c $startScript
else
    echo "TODO 23545, aborting"
    exit 1
fi

#  eula

echo eula=true> $outDir/eula.txt
echo
echo "The server is ready to start. Script: $SCRIPTDIR/$startScript"
