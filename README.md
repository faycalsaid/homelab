

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

