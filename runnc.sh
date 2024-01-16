#!/bin/bash

# cd to Downloads folder (or wherever you keep the AppImages, change 
# accordingly) in case the script is executed from somewhere else
cd ~/Downloads

sleep 10 # in case of autostart, wait some seconds for internet connection to come up


wget -q --spider https://github.com

if [ $? -eq 0 ]; then
echo "Online."
# get latest release version 
newest=$(wget https://github.com/nextcloud-releases/desktop/releases/latest  2>&1 | grep "Location:" | grep -oP '[.0-9]+' | tail -1)

echo "Latest version in github repo: $newest"

# get latest version in folder
current=$(ls Nextcloud-*AppImage | sort | tail -1 | grep -oP '(-)[.0-9]+' | cut -c2-)
echo " Latest current verion in $(pwd): $current"

# download latest version if an update is available
if [ "$current" != "$newest" ]; then
    cmd="wget https://github.com/nextcloud-releases/desktop/releases/download/v$newest/Nextcloud-$newest-x86_64.AppImage"
    eval "$cmd"
    # make executable
    cmd="chmod +x Nextcloud-$newest-x86_64.AppImage"
    eval "$cmd"
fi
fi

# run latest version
pre="./"
string="$(ls Nextcloud-*AppImage | sort | tail -1)"
post=" --background &!"
eval $pre$string$post

