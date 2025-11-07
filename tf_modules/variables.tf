variable "resource_group_name" {
  type        = string
  default     = "myTFResourceGroup"
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region"
}

variable "virtual_network_name" {
  type        = string
  default     = "myTFVnet"
  description = "Name of the virtual network"
}

variable "address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Address space for the virtual network"
}

variable "subnet_prefix" {
  type        = string
  default     = "10.0.1.0/24"
  description = "Subnet address prefix"
}

variable "prefix" {
  type        = string
  default     = "tf"
  description = "Prefix for naming resources"
}

variable "vm_size" {
  type        = string
  default     = "Standard_L2aos_v4"
  description = "Size of the virtual machine"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}

variable "ssh_public_key_path" {
  type        = string
  default     = "/home/azuser/.ssh/authorized_keys"
  description = "Path to SSH public key"
}

variable "golden_image_id" {
  type        = string
  description = "Azure Managed Image ID (Golden AMI)"
}
