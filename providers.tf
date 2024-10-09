terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}

# Initialize the Azure provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
#   client_id       = var.client_id
#   client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
