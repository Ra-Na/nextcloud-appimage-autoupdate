#!/bin/bash

sleep 5  # in case of autostart, wait some seconds for internet connection to come up

# get latest release version 
newest=$(curl 'https://github.com/nextcloud-releases/desktop/releases' | grep -oP '(?<=Link">Release )[.0-9]+' | head -1)

echo -e "\n\n\nLatest version in github repo: $newest"

# get latest version in folder
current=$(ls Nextcloud-*AppImage | sort | tail -1 | grep -oP '(-)[.0-9]+' | cut -c2-)
echo -e "Latest current verion in $(pwd): $current \n\n\n"

# download latest version if an update is available
if [ "$current" != "$newest" ]; then
    cmd="wget https://github.com/nextcloud-releases/desktop/releases/download/v$newest/Nextcloud-$newest-x86_64.AppImage"
    eval "$cmd"
    # make executable
    cmd="chmod +x Nextcloud-$newest-x86_64.AppImage"
    eval "$cmd"
fi

# run latest version
pre="./"
string="$(ls Nextcloud-*AppImage | sort | tail -1)"
post=" --background &!"
eval $pre$string$post
