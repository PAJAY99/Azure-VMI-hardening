packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 2.5.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

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

source "azure-arm" "ubuntu" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  location             = var.location
  vm_size              = var.vm_size
  os_type              = "Linux"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-jammy"
  image_sku            = "22_04-lts-gen2"
  image_version        = "latest"
  managed_image_name   = "golden-ubuntu-image"
  resource_group_name  = "packer-temp"
  capture_container_name = "images"
  capture_name_prefix  = "golden"
}

build {
  name = "Golden Ubuntu Image with jq"
  sources = [
    "source.azure-arm.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "provisioner/jqsetup.yml"
    user          = "packer"
  }
}
