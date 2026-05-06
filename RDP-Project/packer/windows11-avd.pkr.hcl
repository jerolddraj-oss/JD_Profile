packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 1.0.0"
    }
  }
}

source "azure-arm" "windows11" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  managed_image_resource_group_name = "packer-images-rg"
  managed_image_name                = "windows11-avd-image"

  os_type         = "Windows"
  image_publisher = "MicrosoftWindowsDesktop"
  image_offer     = "windows-11"
  image_sku       = "win11-22h2-pro"

  location        = "East US"
  vm_size         = "Standard_D4s_v5"
}

build {
  sources = ["source.azure-arm.windows11"]
}
