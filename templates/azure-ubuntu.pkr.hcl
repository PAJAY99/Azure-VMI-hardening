packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

variable "client_id" {
  type    = string
  default = "your-azure-client-id"
}

variable "client_secret" {
  type    = string
  default = "your-azure-client-secret"
}

variable "tenant_id" {
  type    = string
  default = "your-azure-tenant-id"
}

variable "subscription_id" {
  type    = string
  default = "your-azure-subscription-id"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

source "azure-arm" "ubuntu" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  location             = var.location
  vm_size              = var.vm_size
  os_type              = "Linux"
  image_publisher      = "Canonical"
  image_offer          = "UbuntuServer"
  image_sku            = "22_04-lts"
  managed_image_name   = "packer-ubuntu-image"
  managed_image_resource_group_name = "packer-images"
  resource_group_name  = "packer-temp"
  storage_account      = "packerstorageacct"
  capture_container_name = "images"
  capture_name_prefix  = "packer"

  tags = {
    environment = "Development"
    owner       = "DevOps Team"
  }
}

build {
  name = "Custom Ubuntu Image with jq"
  sources = [
    "source.azure-arm.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "provisioner/jqsetup.yml"
    user          = "packer"
  }
}
