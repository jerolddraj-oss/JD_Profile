module "networking" {
  source              = "./modules/networking"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.networking.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = var.resource_group_name
  location            = var.location
}
