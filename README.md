# continuwuity compose config with generator
i still have to figure out how to give the user changes to the configuration to the config.  
keep in mind i maintain this in my free time.  
if you have any problems with this script, DM me on matrix (if possible) via https://matrix.to/#/@lukas:semda.eu or open an issue.
i will respond as fast as possible. i use this on my own server so i will likely be able to help.  

# TLDR:

1. have a domain (yourdomain.tld) and the livekit subdomain (livekit.yourdomain.tld)

2. open your ports if needed:
```
80/tcp             # http and wellknown
443/tcp            # https
443/udp            # i think websocket 😬
8081/tcp           # jwt service
7880/tcp           # livekit / MatrixRCT
7881/tcp           # livekit / MatrixRCT
50100-50200/udp    # livekit / MatrixRCT
```
*a tutorial for popular firewalls will follow*

3. git clone this repo:
```bash
git clone https://github.com/halcyondazer/continuwuity-compose-caddy.git
```

4. install docker with compose: 
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```


5. run the script:
```bash
./setup.sh yourdomain.tld 
```
*it will ask if you want to start the server using compose (should just work if previous requirements are met)*

6. your configuration will be in a folder next to the folder containing the repo, it will look like `continuwuity-yourdomain.tld-1772130249` :
```
├── continuwuity-compose-caddy
│   ├── continuwuity-skeleton
│   │   ├── Caddyfile
│   │   ├── compose.yml
│   │   ├── continuwuity.toml
│   │   ├── jwt.env
│   │   └── livekit.yaml
│   ├── LICENSE
│   ├── README.md
│   └── setup.sh
└── continuwuity-yourdomain.tld-1772130249
    ├── Caddyfile
    ├── compose.yml
    ├── continuwuity.toml
    ├── jwt.env
    └── livekit.yaml

```

---

parts and ideas based on https://github.com/linkpy/c10y-livekit-docker-compose  
Thank you Kaesa, probably would still guess without your help  
trans right are human rights🏳️‍⚧️  


