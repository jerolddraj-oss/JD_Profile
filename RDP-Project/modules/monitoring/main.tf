resource "azurerm_log_analytics_workspace" "law" {
  name                = "rdp-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "vm_diag" {
  name                       = "vm-diagnostics"
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {
    category = "Administrative"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
