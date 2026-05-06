terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.x.x"
    }
  }

  # Remote backend configuration using Azure Storage Account
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestore123"
    container_name       = "tfstate"
  }
}
