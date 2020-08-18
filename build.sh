#!/bin/bash

set -x

# Your fat/shadow jar should be in the same dir as build.sh 
# Modify these vars as desired
source vars.env

# Setup vars and dirs
WORKDIR=$(pwd)
APPDIR=$WORKDIR/AppDir
mkdir $APPDIR
mkdir $APPDIR/libs
mkdir $APPDIR/jre
cp ./icon.svg $APPDIR/icon.svg
cp ./AppRun $APPDIR/AppRun

# make .desktop file
cat << EOF > /$APPDIR/.desktop
[Desktop Entry]
Version=$VERSION
Type=Application
Categories=$CATEGORIES
Terminal=false
Exec=AppRun
Name=$APPNAME
Icon=icon
EOF

# Download JRE, works now, could break if the jq starts returning more than one value bases on these filters
wget -q -O jre.tar.gz https://api.adoptopenjdk.net/v3/binary/latest/11/ga/linux/x64/jre/hotspot/normal/adoptopenjdk
# Download linuxdeploy
wget -q -O - "https://api.github.com/repos/linuxdeploy/linuxdeploy/releases" | jq -r ".[] | .assets[] | select(.name==\"linuxdeploy-x86_64.AppImage\") | .browser_download_url" | xargs wget -q -O linuxdeploy.AppImage

tar -C $WORKDIR/AppDir/jre -zxf jre.tar.gz --strip-components=1

# If there is not exactly one jar file present, exit
if [ $(ls -1q *.jar | wc -l) -ne 1 ]; then 
    exit 1
else
    cp ./*.jar $APPDIR/libs/app.jar
fi

chmod +x ./linuxdeploy.AppImage

# make the AppImage
if ! ./linuxdeploy.AppImage --output appimage --appdir $APPDIR;
    then echo "appimage creation failed";
else echo "appimage creation successful"
fi
