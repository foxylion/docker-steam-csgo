#!/bin/bash
set -e
trap '' TERM INT HUP

# Ensure csgo is up to date
./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit

if [ -d /home/steam/htdocs ]; then
	echo "Copying htdocs..."
	cp -fR /home/steam/csgo/csgo/maps /home/steam/htdocs
	cp -fR /home/steam/csgo/csgo/sound /home/steam/htdocs
fi

cd csgo
./srcds_run -game csgo +exec server.cfg +hostname "$CSGO_HOSTNAME" +sv_password "$CSGO_PASSWORD" +rcon_password "$RCON_PASSWORD" +sv_setsteamaccount "$STEAM_ACCOUNT_TOKEN" +map de_dust2
