# Automating Proxmox VM Deployment with Terraform

This document explains how to use Terraform to provision VMs on Proxmox using the Cloud-Init template created previously.

**Prerequisites:** You must first set up Proxmox with a Cloud-Init template and optional external storage as described in
README-Proxmox.md
Without that step, Terraform cannot clone VMs automatically.

1. Initialize Your Terraform Project
   Run the following commands from the directory containing your .tf files:
```bash
   terraform init          # Downloads Proxmox provider and initializes backend
   terraform validate      # Checks syntax and variables
```

2. Plan before applying
    * Always run `terraform plan` to preview changes before applying them
    * To focus on a specific VM, use the `-target` flag, e.g., to plan only the bastion VM:
    ```bash
    terraform plan -target=proxmox_vm_qemu.bastion
    ```
   
3. Apply the Configuration
   ```bash
   terraform apply
   ```

# Disaster Recovery: Configure Proxmox for Terraform Provider

## Create a Proxmox API User with Required Privileges [Source](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-proxmox-user-and-role-for-terraform)
```bash 
  pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
  pveum user add terraform-prov@pve --password <password>
  pveum aclmod / -user terraform-prov@pve -role TerraformProv
```

## Create a Linux User for Snippets Upload
```bash 
sudo adduser terraform-ssh
chown -R root:www-data /var/lib/vz/snippets
chmod 775 /var/lib/vz/snippets
usermod -aG www-data terraform-ssh
```

## Create VMs with Terraform

* Go to your terraform directory , and create environment variables for Proxmox provider authentication, run the following commands in your shell (adjust values as needed):
```bash 
export PM_USER="terraform-prov@pve"
export PM_PASS="<password>"
```

* Create a terraform.tfvars file with the following content (adjust values as needed), **the pve user here is the linux user created previously** to interact with Proxmox VE snippets storage
```hcl
pve_host     = "your.proxmox.ve.ip.or.hostname"
pve_user     = "terraform-ssh"
pve_password = "password-of-terraform-ssh-user"

server_admin_public_key    = "your-ssh-public-key"
```
pve_user is the Linux user used to upload Cloud-Init snippets and interact with storage.

* Run the following commands to initialize, validate, plan, and apply your Terraform configuration:
```bash
terraform init
terraform validate
terraform plan
terraform apply
```


# If you already have an existing VM and just want to see what Terraform thinks it is:

If using directly the provider, the syntax is:
```bash
terraform import proxmox_vm_qemu.<ressource_name> pve/qemu/<ressource_id_on_proxmox>
```
example: 
```bash
terraform import proxmox_vm_qemu.media_vm pve/qemu/100
```

Since we're using our custom module, the syntax is slightly different:
```bash
terraform import module.media_vm.proxmox_vm_qemu.<ressource_name> pve/qemu/<ressource_id_on_proxmox>
```
example:
```bash
terraform import module.media_vm.proxmox_vm_qemu.vm pve/qemu/100
```

Then run `terraform plan` plan to see what terraform thinks of the existing VM


If you want to "terraformise" your exisitng homelab you can get actual configuration in JSON and then create the terraform files based on that.

example: `pvesh get /nodes/pve/qemu/100/config --output-format json-pretty`
