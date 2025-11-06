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

variable "location" {
  type    = string
  default = "East US"
}

variable "vm_size" {
  type    = string
  default = "Standard_L2aos_v4"
}

source "azure-arm" "ubuntu" {

  location             = var.location
  vm_size              = var.vm_size
  os_type              = "Linux"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-jammy"
  image_sku            = "22_04-lts-gen2"
  image_version        = "latest"
  managed_image_name   = "golden-ubuntu-image"
  managed_image_resource_group_name = "AzureAMI"
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
