#!/bin/bash

# cd to Downloads folder (or wherever you keep the AppImages, change 
# accordingly) in case the script is executed from somewhere else
cd ~/Downloads

sleep 10 # in case of autostart, wait some seconds for internet connection to come up

online=$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo yes || echo no)

echo "online: $online"

if [ "$online" == "yes" ]; then

# get latest release version 
newest=$(wget https://github.com/nextcloud-releases/desktop/releases/latest  2>&1 | grep "Location:" | grep -oP '[.0-9]+' | tail -1)

echo -e "\n\n\n Latest version in github repo: $newest"

# get latest version in folder
current=$(ls Nextcloud-*AppImage | sort | tail -1 | grep -oP '(-)[.0-9]+' | cut -c2-)
echo -e " Latest current verion in $(pwd): $current \n\n\n"

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

