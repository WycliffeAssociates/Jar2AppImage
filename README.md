# Jar2AppImage
Generic scripts and documentation to take a jdk11 fat or shadow jar and make it into a linux AppImage bundled with a jdk11 jre. Uses [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy) and [AdoptOpenJDK 11](https://github.com/AdoptOpenJDK/openjdk11-binaries)

## Usage

1. Put a shadow/fat jar at the same place as build.sh
1. Edit or replace the vars.env file to contain your appname, version, categories, and arch as needed.
1. Run ./build.sh
1. Appimage will be output at the root.

There are some comments in vars.env and build.sh that might be helpful
