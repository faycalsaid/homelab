# Ansible Role: Monitoring (Prometheus, Grafana & cAdvisor

Role to deploy a lightweight monitoring stack using Docker.
This role installs and configures Prometheus, Grafana, and cAdvisor to monitor containerized workloads and host usage.

A node can act as master (Prometheus + Grafana + cAdvisor)

Other nodes run cAdvisor only

Prometheus scrapes all nodes, based on Ansible inventory values

This setup is ideal for small homelabs, Proxmox nodes, or Docker-based clusters.

## Requirements

Docker Engine and Docker Compose v2 installed on the target host

Inventory must define the Prometheus configuration template path if the host is a master

## Role Variables

These variables control which monitoring components are deployed and how services are configured.

### Base directory
Defines the working directory for all monitoring services.

```yaml
monitoring_directory: /opt/monitoring
monitoring_role: master            # "master" or "node"
```

Set monitoring_role: "master" to run Prometheus + Grafana + cAdvisor.
Set monitoring_role: "node" to run only cAdvisor.

### Grafana settings

These variables expose application ports through the Gluetun container.
They allow other containers running in network_mode: "container:gluetun" (such as qBittorrent, Sonarr, or Radarr) to be reachable through Gluetun’s network interface.
```yaml
monitoring_grafana_docker_image: grafana/grafana
monitoring_grafana_docker_image_version: latest
monitoring_grafana_host_port: 3001
```

### Prometheus settings

Prometheus loads a configuration template from the inventory files directory.
This file defines scrape targets for all monitored nodes.
```yaml
monitoring_prometheus_docker_image: docker.io/prom/prometheus
monitoring_prometheus_docker_image_version: latest
monitoring_prometheus_host_port: 9090
monitoring_prometheus_configuration_file_src_path: "{{ inventory_dir }}/files/prometheus-configuration.yml.j2"
```

#### Prometheus configuration template example
This file must exist in the inventory under files/ or else if you set another path in `monitoring_prometheus_configuration_file_src_path`:

```yaml
global:
  scrape_interval: 15s # By default, scrape targets every 15 seconds.

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['192.168.1.152:9090']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
  ```

### cAdvisor settings

cAdvisor exposes host and container metrics on /metrics, scrapes by Prometheus.

```yaml
monitoring_cadvisor_docker_image: gcr.io/cadvisor/cadvisor
monitoring_cadvisor_docker_image_version: v0.49.1
monitoring_cadvisor_host_port: 8098

```

## Usage

### Minimal playbook

```yaml
- hosts: bastion-servers
  become: true
  vars:
  roles:
    - docker
    - monitoring
```

# Sources
- https://belginux.com/monitoring-docker-grafana-prometheus-cadvisor/
