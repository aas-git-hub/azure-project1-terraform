variable "azure_region" {
  type        = string
  description = "Azure region to deploy into"
  default     = "canadacentral"
}

variable "project_name" {
  type    = string
  default = "banking3tier"
}

variable "vm_admin_username" {
  type    = string
  default = "azureadmin"
}

variable "vm_admin_password" {
  type      = string
  sensitive = true
}

variable "web_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "app_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "web_instance_count" {
  type    = number
  default = 2
}

variable "app_instance_count" {
  type    = number
  default = 2
}

variable "sql_admin_login" {
  type    = string
  default = "sqladminuser"
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "dns_zone_name" {
  type        = string
  description = "Public DNS zone to host app domain"
}

variable "app_hostname" {
  type        = string
  description = "Hostname (A record) for frontend"
  default     = "bankapp"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM scale sets"
}


