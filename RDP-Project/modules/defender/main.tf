resource "azurerm_security_center_subscription_pricing" "vm_defender" {
  tier          = "Standard"
  resource_type = "VirtualMachines"
}

resource "azurerm_security_center_workspace" "defender_workspace" {
  scope        = var.subscription_id
  workspace_id = var.log_analytics_workspace_id
}
