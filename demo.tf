provider "azurerm" {
  version = "=2.5.0"
  features {}
}

variable "resource_prefix" {
  default = "my"
}

variable "location" {
  default = "westus"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}TFResourceGroup"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}TFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_prefix}TFSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_public_ip" "publicip" {
  name                = "${var.resource_prefix}TFPublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

output "instance_ip_addr" {
  value       = azurerm_public_ip.publicip.ip_address
  description = "The public IP address of the instance."
}