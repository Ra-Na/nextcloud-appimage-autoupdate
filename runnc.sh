#!/bin/bash

# cd to Downloads folder (or wherever you keep the AppImages, change 
# accordingly) in case the script is executed from somewhere else
cd ~/Downloads
rm latest

sleep 10 # in case of autostart, wait some seconds for internet connection to come up

wget -q --spider https://github.com

if [ $? -eq 0 ]; then
echo "Online."
# get latest release version 
curl https://nextcloud.com/install/#install-clients > location
downloadlink=$(grep unixOS location | grep -o -P '(?<=href=\").*(?=\" target)')
newest=$(grep unixOS location | grep -o -P '(?<=href=\").*(?=\" target)' | grep -o -P '(?<=Nextcloud-).*(?=-x86)')

echo "Latest version in github repo: $newest"

# get latest version in folder
current=$(ls Nextcloud-*AppImage | sort | tail -1 | grep -oP '(-)[.0-9]+' | cut -c2-)
echo "Latest current verion in $(pwd): $current"

# download latest version if an update is available
if [ "$current" != "$newest" ]; then
    echo "Trying to update..."
    cmd="wget $downloadlink"
    eval "$cmd"
    # make executable
    cmd="chmod +x Nextcloud-$newest-x86_64.AppImage"
    echo "$cmd"
    eval "$cmd"
fi
else
echo "Offline."
fi

# run latest version
pre="./"
string="$(ls Nextcloud-*AppImage | sort | tail -1)"
post=" --background &!"
echo "Running $pre$string$post:"
eval $pre$string$post
