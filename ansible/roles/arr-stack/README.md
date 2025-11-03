# Ansible Role: ARR Media Stack

Role to deploy and configure the full ARR media automation stack using Docker.
This role manages and runs Radarr, Sonarr, Prowlarr, qBittorrent, Jellyseerr, Jellyfin, and FlareSolverr.

It supports optional VPN routing by attaching containers to an existing VPN container (e.g., Gluetun).

## Requirements

Docker Engine and Docker Compose v2 installed on the target host

(Optional) A separate VPN container (e.g., Gluetun) if using VPN routing, see the [Gluetun role](../gluetun/README.md) for deployment instructions.

## Role Variables

These variables define how the ARR stack containers are deployed, where media/config files are stored, and user permissions for mounted volumes.

### VPN routing
If enabled, all supported containers will use an existing VPN container network namespace. Useful to route torrent traffic through a VPN.
```yaml
arr_stack_use_vpn_routing: false
arr_stack_vpn_container_name:

```

### Shared settings

Defines host paths and common docker config for all ARR apps.

```yaml
arr_stack_host_dir: /opt/arr-stack
arr_stack_host_shared_data_dir: /opt/data/media
arr_stack_container_data_volume_path: /data
arr_stack_media_user: "media"
arr_stack_media_user_puid: 1000
arr_stack_media_user_pgid: 1000
arr_stack_timezone: "Etc/UTC"
```

### Auto-created directories

These directories will be created depending on which services you enable. They store persistent configs and media data.
```yaml
gluetun_directory: /opt/gluetun
```

### Radarr (Movies)

```yaml
arr_stack_radarr_enabled: false
arr_stack_radarr_docker_container_name: radarr
arr_stack_radarr_docker_image: lscr.io/linuxserver/radarr
arr_stack_radarr_docker_image_version: latest
arr_stack_radarr_host_configuration_dir: "{{ arr_stack_host_dir }}/radarr/"
arr_stack_radarr_docker_container_configuration_dir: /config
arr_stack_radarr_movies_dir: "{{ arr_stack_host_shared_data_dir }}/movies"

```

### Sonarr (TV Shows)

```yaml
arr_stack_sonarr_enabled: false
arr_stack_sonarr_docker_container_name: sonarr
arr_stack_sonarr_docker_image: lscr.io/linuxserver/sonarr
arr_stack_sonarr_docker_image_version: latest
```

### Prowlarr (Indexers)

```yaml
arr_stack_prowlarr_enabled: false
arr_stack_prowlarr_docker_container_name: prowlarr
arr_stack_prowlarr_docker_image: lscr.io/linuxserver/prowlarr
arr_stack_prowlarr_docker_image_version: latest
```

### FlareSolverr (Captcha Solver)
```yaml
arr_stack_flaresolverr_enabled: false
arr_stack_flaresolverr_docker_container_name: flaresolverr
arr_stack_flaresolverr_docker_image: ghcr.io/flaresolverr/flaresolverr
arr_stack_flaresolverr_docker_image_version: latest
```

### Jellyseerr (Requests UI)

```yaml
arr_stack_jellyseerr_enabled: false
arr_stack_jellyseerr_docker_container_name: jellyseerr
arr_stack_jellyseerr_docker_image: fallenbagel/jellyseerr
arr_stack_jellyseerr_docker_image_version: latest
```

### Jellyfin (Media Server)
```yaml
arr_stack_jellyfin_enabled: false
arr_stack_jellyfin_docker_container_name: jellyfin
arr_stack_jellyfin_docker_image: jellyfin/jellyfin
arr_stack_jellyfin_docker_image_version: latest
```

### qBittorrent (Torrent Client)

```yaml
arr_stack_qbittorrent_enabled: false
arr_stack_qbittorrent_docker_container_name: qbittorrent
arr_stack_qbittorrent_docker_image: lscr.io/linuxserver/qbittorrent
arr_stack_qbittorrent_docker_image_version: latest
```

## Usage

### Minimal playbook

```yaml
- hosts: media-servers
  become: true
  roles:
    - role: docker        # your docker install role
    - role: arr-stack
```


