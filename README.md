# Below config is not done yet!
# parts based on https://github.com/linkpy/c10y-livekit-docker-compose
# Thank you Kaesa, probably would still guess without your help
---
---

# Continuwuity Docker Compose Setup

This repository contains what you need to get a Continuwuity homeserver up and running.
Some configuration still needs to be changed for it to work.

## What's included ?

This repository contains 5 services :
 - Caddy : used as a reversed proxy and for HTTPS (optional if you already have a reverse proxy).
 - Homeserver : the Continuwuity server.
 - RTC-JWT : the MatrixRTC token service.
 - RTC-LiveKit : the MatrixRTC server.

## How to configure it ?

### Required changes

To make it easy, most things that needs to be changed can be found by searching for `TOCHG` in the files (with a few exceptions).

To avoid ambiguity, here are a few variables :

 - `YOUR_DOMAIN` : Your domain name where your homeserver will be reachable. Exemple: `example.org`, `matrix.mydomain.xyz`.
 - `YOUR_LK_KEY_NAME` : A 20 character long random string. Used with Livekit. If Livekit is disabled, you do not need it.
 - `YOUR_LK_KEY` : A 64 character long random string. Used with Livekit. If Livekit is disabled, you do not need it.

But here is an exhaustive list of required changes :

 - `caddy/Caddyfile:7` : The domain name (`domain.tld`) needs to be changed to `YOUR_DOMAIN`.
 - `caddy/Caddyfile:28` : The domain name (`livekit.domain.tld`) needs to be changed to `livekit.YOUR_DOMAIN`.
 - `homeserver/.env:1` : The domain name (`domain.tld`) needs to be changed to `YOUR_DOMAIN`
 - `homeserver/contiuwuity.toml:37` : The domain name (`domain.tld`) needs to be changed to `YOUR_DOMAIN`
 - `homeserver/contiuwuity.toml:470` : The token (`REGISTRATION_TOKEN`) needs to be changed to a 64 character long random string.
 - `rtc-jwt/.env:2` : The domain (`livekit.domain.tld`) needs to be changed to `livekit.YOUR_DOMAIN`.
 - `rtc-jwt/.env:3` : The domain (`domain.tld`) needs to be changed to `YOUR_DOMAIN`.
 - `rtc-jwt/.env:4` : The key name (`LK_KEY_NAME`) needs to be changed to `YOUR_LK_KEY_NAME`.
 - `rtc-jwt/.env:5` : The key (`LK_KEY`) needs to be changed to `YOUR_LK_KEY`.

Some of the changes cannot be found with a `TOCHG` search :

 - `caddy/static/well-known/matrix/client` : Replace all mentions of `domain.tld` to `YOUR_DOMAIN`.
 - `caddy/static/well-known/matrix/server` : Replace all mentions of `domain.tld` to `YOUR_DOMAIN`.

### Optional changes

Many options can be tweaked to your liking, and they wont be all exhaustively enumerated here. But still, a few notable one needs to be looked at :

- `compose.yml:39` : The default image for Continuwuity is the latest maxperf one, which isnt compatible with old hardware (>15y old). If you use that kind of hardware, you need to remove the `-maxperf` at the end of the line.


### Additional changes out of scope

Additional changes are required for this setup to work, which cannot be covered in this repository.

#### DNS entries

You will need the following DNS entries to point to the public IP of your host :

- `YOUR_DOMAIN`
- `livekit.YOUR_DOMAIN`

If you do not know how to set that up, please refer to your domain provider's documentation.


#### Port forwarding

You will need the following ports on your router to be forwarded to your host :

- 80 (TCP), 443 (TCP + UDP) : Caddy
- 7881 (TCP), 50100 to 50200 (UDP) : MatrixRTC

If you do not know how to set that up, please refer to your ISP documentation or your router's documentation.


## How to run it ?

Once the configuration is done, with a terminal you can simply do `docker compose up -d`. It will download all of the images and start all of the services.

After all services are started, you should be able to open `https://YOUR_DOMAIN/` and you should see Continuwuity's page.
