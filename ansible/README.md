# Ansible

## Developer Guide

Install ansible-core

```bash pip install --upgrade ansible-core```

Install required collections, and if you add any new collection add it to requirements.yml

```bash
ansible-galaxy collection install -r requirements.yml
```

to test for example saying you have a VM part of ubuntu group with IP or domain name defined in your hosts file

Test this command if you want to ping the VM

ansible -i ./inventory/hosts ubuntu -m ping --user someuser --ask-pass

To run a playbook for example

```bash 
  ansible-playbook ./playbooks/docker.yml --user someuser --ask-pass --ask-become-pass -i ./inventory/hosts 
```

But here our VMs are configured to use ssh so just run 

```bash 
  ansible-playbook ./playbooks/site.yml
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
