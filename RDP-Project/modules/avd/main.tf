resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  name                = "rdp-hostpool"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Pooled"
  load_balancer_type  = "BreadthFirst"
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "rdp-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_desktop_application_group" "dag" {
  name                = "desktop-app-group"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Desktop"
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
}
