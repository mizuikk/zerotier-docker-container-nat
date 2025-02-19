# zerotier-docker-container-nat

A container to provide out-of-the-box bridging functionality to a ZeroTier network.

## Running

### Prerequisites

- Docker running as your logged in user (if `docker ps` runs then you're good, if not follow the link ->) - [Linux instructions here](https://docs.docker.com/engine/install/linux-postinstall/)

### Docker Compose

**You need to edit the `ZT_NETWORKS` variable in the `docker-compose.yml` file first to add your networks

Easiest way to bring up is via Docker Compose. Rename `docker-compose.yml.example` to `docker-compose.yml` and run `docker compose up -d`.

If you want to disable bridging, set `ZT_BRIDGE=false`. This can be done after the initial networks have been joined (just change the environment variable in the `docker-compose.yml` file and run `), as the ZeroTier config persists but IPTables forwarding is done on each container startup.

### OG Docker

`docker build -t zerotier-docker-container-nat .`

`docker run --privileged -e ZT_NETWORKS=NETWORK_1 NETWORK_2 -e ZT_BRIDGE=true zerotier-docker-container-nat:latest`

Add your network ID(s) into the `ZT_NETWORKS` argument, space separated.

Disable bridging by passing `ZT_BRIDGE=false`. This can be done after the initial networks have been joined (just rebuild the container), as the ZeroTier config persists but IPTables forwarding is done on each container startup.

#### Persistent Storage

If you would like the container to retain the same ZeroTier client ID on reboot, attach a volume as per the below.

`docker run --privileged -e ZT_NETWORKS=NETWORK_ID_HERE ZT_BRIDGE=true -v zt_config:/var/lib/zerotier-one/ zerotier-docker-container-nat:latest`
