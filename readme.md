This bash script 

1. checks https://github.com/nextcloud-releases/desktop/releases
   for nextcloud desktop client appimage updates,
2. downloads the latest appimage if an update is available,
3. runs the latest version.

Put it where you keep the nextcloud dektop clients appimages 
(usually ~/Downloads), make it executable `chmod +x runnc.sh` 
and run it on each startup automatically.
