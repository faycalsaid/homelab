# Ansible Role: Gluetun

Role to deploy and configure the [Gluetun VPN container](https://github.com/qdm12/gluetun) using Docker.  
This role creates the container with appropriate VPN settings (WireGuard or OpenVPN) and exposes ports for ARR applications (Radarr, Sonarr, Prowlarr, qBittorrent, etc.).

Optionally, you can configure the VPN provider and WireGuard connection details.

## Requirements

- **Docker Engine** and **Docker Compose v2** on the target host

## Role Variables

These variables define the base container properties used when deploying Gluetun.  
They include the container name, image repository, and version tag used to pull the Docker image.

### Gluetun Docker container settings
```yaml
gluetun_docker_container_name: gluetun
gluetun_docker_image: qmcgaw/gluetun
gluetun_docker_image_version: latest
```

### Gluetun Docker container ports

These variables expose application ports through the Gluetun container.
They allow other containers running in network_mode: "container:gluetun" (such as qBittorrent, Sonarr, or Radarr) to be reachable through Gluetun’s network interface.
```yaml
gluetun_docker_port_qbittorrent_ui: 8081
gluetun_docker_port_qbittorrent: 6881
gluetun_docker_port_qbittorrent_udp: 6881
gluetun_docker_port_prowlarr: 9696
gluetun_docker_port_radarr: 7878
gluetun_docker_port_sonarr: 8989
gluetun_docker_port_flaresolverr: 8191
```

### Gluetun volume

This variable defines the directory on the host where Gluetun stores its persistent configuration, runtime state, and WireGuard keys.
The directory is mounted to /gluetun inside the container, it is also where the docker-compose file will be.
```yaml
gluetun_directory: /opt/gluetun
```

### Gluetun VPN settings

These variables configure the VPN connection for Gluetun.
You must set them to connect successfully to your VPN provider.
For now only WireGuard works, specify your private key and assigned address from your provider’s configuration.

```yaml
gluetun_vpn_wireguard_addresses:
gluetun_vpn_service_provider:
gluetun_vpn_type:
gluetun_vpn_wireguard_private_key:
```

## Usage

### Minimal playbook

```yaml
- hosts: media-servers
  become: true
  roles:
    - role: docker          # your docker install role
    - role: gluetun
```


