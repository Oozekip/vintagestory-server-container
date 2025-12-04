# Notes
This is made to to run a Vintage Story 1.21.5 server in a rootless Podman container. 

**This will not handle any network or firewall configuraiton for you**. You are still responsible for opening up any required ports on your router and allowing access through your computers firewall

I made this in part to learn how to use and configure containers; I am by no means an expert at this an have probably made some mistakes.

All scripts are currently only verified to work using rootless Podman on my setup using Arch Linux. They should in theory work on any Linux distribution with Podman installed, as well as on Mac, with the caveat that the script `podman-start.sh` requires the directory `/mnt/vintagestory/data` to exist on the host filesystem and that you have read/write permission. You can easily modify the script to change this if required, and I'm planning to make this more easily customizable in the future. 

# Basic usage

## Building the container
To build the container image, run the `podman-build.sh` script. The container can then be run with `podman-start.sh`, assuming the data directory is corretly set up on the host machine. It can also be run manually with `podman run {args} oozekip/vintagestory-server:1.21.5`

## Server data
By default, the script `podman.start.sh` mounts the host volume `/mnt/vintagestory/` as the server data directory in the container. This will be the directory that contains the server data, eg world, server configuration, mods, player data, etc.

## Executing server commands
You can run commands on the running server using the `server-exec.sh` script. This will simply pass any arguments given to it to the `server.sh` script in the container.

### Examples
Add a player to the server whitelist
```
$ ./server-exec.sh command whitelist add $VS_USERNAME
```
