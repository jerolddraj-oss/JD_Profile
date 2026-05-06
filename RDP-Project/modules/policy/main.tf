resource "azurerm_policy_definition" "allowed_locations" {
  name         = "allowed-locations-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed Azure Regions"

  policy_rule = jsonencode({
    if = {
      field = "location"
      notIn = ["East US", "East US2"]
    }
    then = {
      effect = "deny"
    }
  })
}
