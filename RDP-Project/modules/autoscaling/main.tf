resource "azurerm_monitor_autoscale_setting" "avd_autoscale" {
  name                = "avd-autoscale"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.vmss_id

  profile {
    name = "business-hours"

    capacity {
      default = 2
      minimum = 2
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.vmss_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}
