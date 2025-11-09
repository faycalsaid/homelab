
![homelav-v1.drawio.png](homelav-v1.drawio.png)

# Repository structure
- `ansible/`: Ansible playbooks and roles to configure the homelab services and applications
- `terraform/`: Terraform configurations to create and manage the Proxmox VMs, networks, and storage
- `.proxmox/`: Documentation related to Proxmox VM templates and cloud-init setup and configuration

# Bootstrap everything from scratch / Disaster Recovery guide

This guide will help you to deploy the entire homelab infrastructure and services from scratch using terraform and ansible. This is also useful in case of disaster recovery.

## Prerequisites
- Proxmox server up and running

- Create the infrastrucutre (VMs, networks, storage) by following the instructions in the terraform disaster recovery readme [here](./terraform/README.md)

- SSH to the bastion vm using the ansible user, pull the homelab repository, and run the ansible playbook from there
    
    ```bash
    ansible-playbook ./playbooks/site.yml --ask-vault-pass
    ```

- Configure arr applications through UI (The configuration as code is not yet implemented)
- Generate credentials for all homepage widgets (plex, sonarr, radarr, etc) and put their values in the respective variables in `ansible/group_vars/bastion-servers.yml`
  homepage_config_proxmox_api_user_password
  homepage_config_jellyfin_api_user_password
  homepage_config_radarr_api_user_password
  homepage_config_sonarr_api_user_password
  homepage_config_prowlarr_api_user_password

## Troubleshooting
- If you have the error when clongin the repo:
    ```
    fatal: could not create work tree dir 'homelab': Permission denied
    ```
First check cloud init status, 
    ```bash
    sudo cloud-init status --long
    ```
if it is 'done' then simply give ansible user ownership of the home directory
    ```bash
    sudo chown -R ansible:ansible /home/ansible
    ```

# Sources
- https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
- https://www.reddit.com/r/homelab/comments/q1m383/a_small_but_useful_tip_for_proxmox_users/
- 