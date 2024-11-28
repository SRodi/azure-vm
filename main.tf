# Fetch the resource group (make sure this exists in Azure)
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Define the public IP
resource "azurerm_public_ip" "pub_ip" {
  name                = "${var.prefix}-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Cretae a virtual network
resource "azurerm_virtual_network" "virtual_netowrk" {
  name                = "${var.prefix}-virtual-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.128.0.0/16"] # CIDR notation for the IP range    
}

# Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_netowrk.name
  address_prefixes     = ["10.128.0.0/24"] # CIDR notation for the IP range
}


# Define the network security group
resource "azurerm_network_security_group" "network_security_group" {
  name                = "${var.prefix}-network-security-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.prefix}-network-interface"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub_ip.id
  }
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.prefix}-vm"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  size                = "Standard_D2pds_v5"
  admin_username      = var.prefix

  network_interface_ids = [
    azurerm_network_interface.network_interface.id
  ]

  os_disk {
    caching              = "ReadWrite" # ["None" "ReadOnly" "ReadWrite"]
    storage_account_type = "Standard_LRS" # ["Premium_LRS" "Standard_LRS" "StandardSSD_LRS" "StandardSSD_ZRS" "Premium_ZRS"]
  }

  source_image_reference {
    publisher = "almalinux"
    offer     = "almalinux-arm"
    sku       = "9-arm-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.prefix
    public_key = file("${var.path_to_public_key}")
  }
}

output "ssh_command" {
  value = "ssh ${var.prefix}@${azurerm_public_ip.pub_ip.ip_address}"
}