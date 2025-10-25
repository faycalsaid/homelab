variable "vmid" {}
variable "name" {}
variable "clone_source" { default = "" }
variable "snippet_path" { default = "" }
variable "target_node" {}
variable "cores" {}
variable "sockets" {}
variable "memory" {}
variable "onboot" { default = true }
variable "disk_size" {}
variable "network_id" { default = 0 }
variable "disk_storage" { default = "local-lvm" }
variable "enable_firewall" { default = false }
variable "ipconfig0" {}

variable "extra_disk_storage" {
  description = "Storage backend for the extra disk (e.g., 'additional-storage')"
  type        = string
  default     = null
}

variable "extra_disk_size" {
  description = "Size of the extra disk (e.g., '400G')"
  type        = string
  default     = null
}


# Ansible related variables
variable "is_ansible_runner" {
  description = "If true, provisions the VM as an Ansible runner (with private key and ansible-core)."
  type        = bool
  default     = false
}

variable "ansible_public_key" {
  description = "The public SSH key to inject for the user."
  type        = string
  sensitive   = true
}

variable "ansible_private_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "server_admin_public_key" {
  type      = string
  default   = ""
  sensitive = true
}

# Needed to connect to Proxmox VE for uploading cloud-init snippets
variable "pve_user" {
  description = "Proxmox SSH user (e.g., root@pam)"
  type        = string
}

variable "pve_password" {
  description = "Password for Proxmox SSH user"
  type        = string
  sensitive   = true
}

variable "pve_host" {
  description = "Proxmox host IP or hostname"
  type        = string
}
