variable "client_id" {
  type    = string
  default = "db245360-7c18-4d9b-bf5e-85d6013e91ea"
}

variable "client_secret" {
  type    = string
  default = "q3s8Q~ZGT83UZV6NtwhFpfgS9PQIshtcAH8b~ar~"
}

variable "tenant_id" {
  type    = string
  default = "95bdb50c-a497-4bcf-8fa1-9088dc83f67d"
}

variable "subscription_id" {
  type    = string
  default = "2c8e92b4-8e2f-4252-af6e-c25fee6f3496"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vm_size" {
  type    = string
  default = "Standard_L2aos_v4"
}


variable "resource_group_name" {
  type        = string
  default     = "AzureAMI"
  description = "Name of the resource group"
}

variable "subnet_name" {
  default = "default"
}

variable "image_version" {
  default = "latest"
}

variable "image_definition" {
  default = ""
}

variable "virtual_network_name" {
  type        = string
  default     = "Azure_VNet_AMI"
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

variable "gallery_name" {
  default = "AMIImages"
}

variable "prefix" {
  type        = string
  default     = "tf"
  description = "Prefix for naming resources"
}

variable "az_pub_key" {
  default = ""
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}