# Warning

0. You do **not** need to check the "Active bridge" configuration box.

1. When creating a Docker network with a subnet like `--subnet=172.18.0.0/16` and attempting to add a route (e.g., Target: `172.18.0.0/16`, Gateway: `10.6.6.1`), the route **may fail to be created**. You can verify this by running `route -n` on the ZeroTier client side. This suggests that ZeroTier may not fully support routes with a `/16` subnet mask.

   However, when using a `/24` subnet configuration (e.g., `--subnet=192.168.2.0/24`, Gateway: `192.168.2.1`), the route is successfully created, allowing all ZeroTier clients to access the `192.168.2.0/24` subnet.

### Key Observations:
- `/16` subnet routes may not function as expected in ZeroTier.
- `/24` subnet configurations appear to work reliably.
- Always verify routes with `route -n` on client devices.

**- The A and B segments of your target address may need to be the same as the local ones, for example, 192.168.2.0/24.**

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
