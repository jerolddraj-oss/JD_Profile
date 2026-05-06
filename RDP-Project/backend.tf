terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "rdpterraformstate"
    container_name       = "tfstate"
    key                  = "rdp-project.tfstate"
  }
}
