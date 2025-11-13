# Ansible Role: Homepage

This role deploys [Homepage by gethomepage](https://gethomepage.dev/), a modern, fully static, fast, secure, and highly customizable application dashboard.

## Table of Contents

-   [Requirements](#requirements)
-   [Role Variables](#role-variables)
-   [Usage](#usage)

## Requirements

-   Docker Engine and Docker Compose v2 on the target host.

## Role Variables

### `homepage_directory`

The directory on the host where the Homepage configuration and `docker-compose.yml` file will be stored.

```yaml
homepage_directory: /opt/homepage
```

### Docker Container Settings

These variables define the Docker container settings for the Homepage application.

```yaml
homepage_docker_image: ghcr.io/gethomepage/homepage
homepage_docker_image_version: latest
homepage_host_port: 3000
```

### Configuration Files

These variables define the source and destination for the Homepage configuration files.

-   `homepage_config_src`: The source directory containing the configuration files to be templated.
-   `homepage_config_host_path`: The destination directory on the host where the configuration files will be placed.

```yaml
homepage_config_src:
homepage_config_host_path: "{{ homepage_directory }}/config"
```

### `homepage_allowed_hosts`

A comma-separated list of allowed hosts for the Homepage application. Set to `""` to allow all hosts.

```yaml
homepage_allowed_hosts: ""
```

## Usage

### Minimal Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: install-docker
    - role: homepage
      vars:
        homepage_config_src: "inventory/files/homepage-config"
```
