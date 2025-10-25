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

variable "server_admin_public_key" {
  type      = string
  default   = ""
  sensitive = true
}