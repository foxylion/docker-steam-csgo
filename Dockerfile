FROM ubuntu:20.04
LABEL author="Jakob Jarosch <dev@jakobjarosch.de>"

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 unzip nginx

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam
USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install CSGO once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit # Update to date as of 2020-12-04

ENV CSGO_HOSTNAME Counter-Strike Source Dedicated Server
ENV CSGO_PASSWORD ""
ENV RCON_PASSWORD mysup3rs3cr3tpassw0rd
ENV STEAM_ACCOUNT_TOKEN ""

EXPOSE 27015/udp
EXPOSE 27015

RUN ln -s /home/steam/linux32 /home/steam/.steam/sdk32

ADD ./entrypoint.sh entrypoint.sh

CMD ./entrypoint.sh
