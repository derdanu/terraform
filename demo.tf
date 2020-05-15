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