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