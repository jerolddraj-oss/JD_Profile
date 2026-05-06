resource "azurerm_windows_virtual_machine_scale_set" "avd_vmss" {
  name                = "avd-sessionhost-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard_D4s_v5"
  instances           = 2
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-pro"
    version   = "latest"
  }

  network_interface {
    name    = "vmssnic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }
}
