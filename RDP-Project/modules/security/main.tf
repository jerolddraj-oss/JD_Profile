resource "azurerm_network_security_group" "rdp_nsg" {
  name                = "rdp-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-RDP-From-Bastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "AzureBastion"
    destination_address_prefix = "*"
  }
}

resource "azurerm_key_vault" "kv" {
  name                        = "rdp-project-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
}
