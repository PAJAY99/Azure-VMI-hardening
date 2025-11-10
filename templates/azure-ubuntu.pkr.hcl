packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

variable "client_id" {
  type    = string
  default = env("CLIENT_ID")
}

variable "client_secret" {
  type    = string
  default = env("CLIENT_SECRET")
}

variable "tenant_id" {
  type    = string
  default = env("TENANT_ID")
}

variable "subscription_id" {
  type    = string
  default = env("SUBSCRIPTION_ID")
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vm_size" {
  type    = string
  default = "Standard_DC1s_v3"
}

variable "gallery_resource_group" {
  type = string
  default = "AzureAMI"
}

variable "image_version" {
  type = string
  default = "1.0.0"
}

variable "image_name" {
  type = string
  default = "golden-ubuntu-image"
}

variable "gallery_name" {
  type = string
  default = "Ubuntu_AMI"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
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

  
shared_image_gallery_destination {
    resource_group         = var.gallery_resource_group
    gallery_name           = var.gallery_name
    image_name             = var.image_name
    image_version          = var.image_version
    storage_account_type   = "Standard_LRS"
  }
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
