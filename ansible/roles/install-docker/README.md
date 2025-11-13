# Ansible Role: Install Docker

This role installs Docker CE on Ubuntu.

## Table of Contents

-   [Requirements](#requirements)
-   [Role Variables](#role-variables)
-   [Dependencies](#dependencies)
-   [Example Playbook](#example-playbook)
-   [License](#license)

## Requirements

-   This role is intended for **Ubuntu** distributions.

## Role Variables

### `docker_sudo_users`

A list of usernames to be added to the `docker` group. This allows them to run Docker commands without `sudo`.

```yaml
docker_sudo_users: []
```

### `docker_version`

The Docker CE version to install. You can specify a full version number or use wildcards (`*`) to get the latest version.

```yaml
docker_version: "*.*.*"
```

Examples:

-   `26.1.3`: Install Docker CE 26.1.3.
-   `26.1.*`: Install the latest patch version of Docker CE 26.1.
-   `*.*.*`: Install the latest available version of Docker CE.

## Dependencies

There are no dependencies for this role.

## Example Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: install-docker
      vars:
        docker_sudo_users:
          - manager
          - john
        docker_version: "26.1.*"
```

## License

MIT License

## Source

-   [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
