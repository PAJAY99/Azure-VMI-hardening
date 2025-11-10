provider "azurerm" {
  features {}

client_id       = var.client_id
client_secret   = var.client_secret
tenant_id       = var.tenant_id
subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                = "${var.prefix}-vm"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.location
  vm_size                = var.vm_size
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  delete_os_disk_on_termination = true

  storage_os_disk {
    name = "AzureAMIImage"
    caching              = "ReadWrite"
    create_option = "fromImage"
    managed_disk_type = "Standard_LRS"
  }

os_profile {
  computer_name = "ubuntu-server"
  admin_username = var.admin_username
}

os_profile_linux_config {
  disable_password_authentication = true
  }
}