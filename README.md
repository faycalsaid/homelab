

# Disaster Recovery

# Bootstrap everything from scratch
## Prerequisites
- VMs with Ubuntu 22.04 installed
- SSH access to the VMs
- Ansible installed on your local machine, the following instructions are for Ubuntu/Debian based systems (See Developer Guide section for more details)
- Luanch the following command with the appropriate user

```bash
ansible-playbook ./playbooks/site.yml --user <appropriate-user> --ask-pass --ask-become-pass 
```

Configure proxmox

Create the infrastrucutre (VMs, networks, storage) by following the instructions in the terraform disaster recovery readme [here](./terraform/README.md)

SSH to the bastion vm using the ansible user, pull the homelab repository, and run the ansible playbook from there

```bash
ansible-playbook ./playbooks/site.yml
```

Configure arr applications through UI (The configuration as code is not yet implemented)

## Troubleshooting
- If you have the error when clongin the repo:
```
fatal: could not create work tree dir 'homelab': Permission denied
```
First check cloud init status, 
```bash
sudo cloud-init status --long
```
if it is 'done' then simply run
Fix permission 
