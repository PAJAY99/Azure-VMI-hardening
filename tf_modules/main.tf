provider "azurerm" {
  features {}

client_id       = var.CLIENT_ID
client_secret   = var.CLIENT_SECRET
tenant_id       = var.TENANT_ID
subscription_id = var.SUBSCRIPTION_ID
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = "vm-nsg"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip_${formatdate("YYYYMMDDhhmm", timestamp())}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"

}


resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}_${formatdate("YYYYMMDDhhmm", timestamp())}-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}_${formatdate("YYYYMMDDhhmm", timestamp())}-vm"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  location              = var.location
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "AzureVMImage_${formatdate("YYYYMMDDhhmm", timestamp())}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "ubuntu-server"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file("${var.az_pub_key}")
    }
  }
}