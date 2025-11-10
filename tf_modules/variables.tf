variable "CLIENT_ID" {
  description = "client's id"
  type    = string
}

variable "CLIENT_SECRET" {
  description = "client's secret"
  type    = string
}

variable "TENANT_ID" {
  description = "tenant's id"
  type    = string
}

variable "SUBSCRIPTION_ID" {
  description = "subscription id"
  type    = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vm_size" {
  type    = string
  default = "Standard_DC1s_v3"
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

variable "image_name" {
  default = "golden-ubuntu-image"
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
  description = "Path to the public SSH key"
  type        = string
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}