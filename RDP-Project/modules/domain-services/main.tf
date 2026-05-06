resource "azurerm_virtual_machine_extension" "domain_join" {
  name                 = "domainJoin"
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "Name": "corp.local",
        "OUPath": "OU=AVD,DC=corp,DC=local",
        "User": "corp\\domainjoinuser",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "ReplaceWithKeyVaultSecret"
    }
PROTECTED_SETTINGS
}
