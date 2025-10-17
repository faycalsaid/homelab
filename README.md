

# Ansible

## Developer Guide

```bash pip install --upgrade ansible-core```

to test for example saying you have a VM part of ubuntu group with IP or domain name defined in your hosts file

You need to install python manually on the VMs until they are provided using terraform with pyhton installed

Test this command if you want to ping the VM

ansible -i ./inventory/hosts ubuntu -m ping --user someuser --ask-pass

To run a playbook for example 

```bash 
  ansible-playbook ./playbooks/apt.yml --user feycce --ask-pass --ask-become-pass -i ./inventory/hosts 
```

## 🧩 Special Notes

Although this repository follows standard Ansible conventions for group_vars and host_vars,
YAML files in those directories are not Jinja-evaluated by default.

To enable variable interpolation (e.g. referencing one variable from another) inside inventory variable files,
a small pre-task is added in the playbooks to explicitly load and render them as templates.
This ensures that all variables are properly evaluated and reusable throughout the playbook and roles.

```yaml
  pre_tasks:
    - name: Load evaluated group vars (to resolve Jinja expressions)
      include_vars:
        file: "/group_vars/media-servers.yml"
```


# Disaster Recovery

# Bootstrap everything from scratch
## Prerequisites
- VMs with Ubuntu 22.04 installed
- SSH access to the VMs
- Ansible installed on your local machine, the following instructions are for Ubuntu/Debian based systems (See Developer Guide section for more details)
- 


## Steps
1. Clone the repository
2. 
   