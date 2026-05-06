# Resource Group for networking
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

# 1. Hub VNet
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.cidr_block_hub]
}

# Subnets in Hub (Firewall, Management)
resource "azurerm_subnet" "hub_subnet_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 2. Spoke 1 VNet
resource "azurerm_virtual_network" "spoke1" {
  name                = "vnet-spoke1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.cidr_block_spoke1]
}

# 3. Spoke 2 VNet
resource "azurerm_virtual_network" "spoke2" {
  name                = "vnet-spoke2"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.cidr_block_spoke2]
}

# Subnet in Spoke 1 (AKS Nodes)
resource "azurerm_subnet" "spoke1_subnet_aks" {
  name                 = "snet-aks-nodes"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke1.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Subnet in Spoke 2 (AKS Nodes)
resource "azurerm_subnet" "spoke2_subnet_aks" {
  name                 = "snet-aks-nodes"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke2.name
  address_prefixes     = ["10.2.1.0/24"]
}

# 4. VNet Peering (Hub <-> Spoke 1)
resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                         = "peering-hub-to-spoke1"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke1.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
  name                         = "peering-spoke1-to-hub"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.spoke1.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
}

# 5. VNet Peering (Hub <-> Spoke 2)
resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                         = "peering-hub-to-spoke2"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke2.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke2_to_hub" {
  name                         = "peering-spoke2-to-hub"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.spoke2.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "spoke1_vnet_id" {
  value = azurerm_virtual_network.spoke1.id
}

output "spoke2_vnet_id" {
  value = azurerm_virtual_network.spoke2.id
}
