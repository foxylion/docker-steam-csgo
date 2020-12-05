
build:
	docker build -t foxylion/steam-csgo .

run:
	docker run -d -p 27015:27015 \
	              -p 27015:27015/udp \
	              --name csgo-server-27015 \
	              foxylion/steam-csgo
