#!/bin/bash
set -e
trap '' TERM INT HUP

# Ensure csgo is up to date
./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

if [ -d /home/steam/htdocs ]; then
	echo "Copying htdocs..."
	mkdir -p /home/steam/htdocs/csgo
	cp -fR /home/steam/css/csgo/maps /home/steam/htdocs/csgo
	cp -fR /home/steam/css/csgo/sound /home/steam/htdocs/csgo
fi

cd csgo
./srcds_run -game csgo +exec server.cfg +hostname "$CSGO_HOSTNAME" +sv_password "$CSGO_PASSWORD" +rcon_password "$RCON_PASSWORD" +map de_dust2