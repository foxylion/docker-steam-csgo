# Docker Image for Counter-Strike Global Offensive

This docker image provides a preconfigured Counter-Strike Global Offensive server with several plugins.

List of used plugins:

- [metamod:source v1.11 b1143](http://www.metamodsource.net/)
- [SourceMod v1.10 b6499](http://www.sourcemod.net/downloads.php?branch=stable)
- [Quake Sounds v3.5](https://forums.alliedmods.net/showthread.php?t=224316)
- [MapChooser Extended 1.10.2](https://forums.alliedmods.net/showthread.php?t=156974)

## Start the container

The docker container requires some ports to be exposed, therefore a more advanced run command is required.

```
docker run -d --name csgo-server-27015 \
           -p 27015:27015 -p 27015:27015/udp \
           -e RCON_PASSWORD=mypassword \
           -e STEAM_ACCOUNT_TOKEN=my_token \ # Required when running a public (non LAN) server
           foxylion/steam-csgo
```

## Restart the container

Due to the linux kernel is caching the udp connection state you have to manually clean the udp connection tracking, before you can immediately reconenct to the server. More details can be found [here](https://github.com/docker/docker/issues/8795).

```
apt-get install conntrack
conntrack -D -p udp
```

## Available Environment Variables

- `RCON_PASSWORD` is your personal RCON password to authenticate as the administrator
- `CSGO_HOSTNAME` is your custom server name shown in the server list
- `CSGO_PASSWORD` is the password a user may require to connect, can be left empty

## Expose you maps as a htdocs directory

You can mount a directory where the csgo server should copy all currently installed maps so you can use the `sv_downloadurl` option.

```
- v /path/to/target:/home/steam/htdocs
```

## Other files to override

### Custom mapcycle.txt

```
-v /path/to/mapcycle.txt:/home/steam/csgo/cstrike/cfg/mapcycle.txt
```

### Modified server.cfg

The default server.cfg can also be overriden, therefore use the following pattern

```
-v /path/to/my-server.cfg:/home/steam/csgo/cstrike/cfg/server.cfg
```

### Other configuration files

Any other configuration file can also be overriden using the same method as above, you must just locate the right file in the docker container. The folder structure is the same as when you install the server locally.

### A full configuration example

```
docker run --rm -it --name csgo \
           -p 27015:27015 -p 27015:27015/udp \
           -e RCON_PASSWORD=my-password \
           -e STEAM_ACCOUNT_TOKEN=my-token-from-steam \
           -v /etc/csgo/mapcycle.txt:/home/steam/csgo/csgo/cfg/mapcycle.txt \
           -v /etc/csgo/server.cfg:/home/steam/csgo/csgo/cfg/server.cfg \
           -v /var/www/public/csgo:/home/steam/htdocs:rw \
           foxylion/steam-csgo
```
