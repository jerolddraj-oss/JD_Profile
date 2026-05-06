module "networking" {
  source              = "./modules/networking"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
}

module "security" {
  source              = "./modules/security"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
}

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = var.resource_group_name
  location            = var.location
  bastion_subnet_id   = module.networking.bastion_subnet_id
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.networking.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "vmss" {
  source              = "./modules/vmss"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.networking.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "autoscaling" {
  source              = "./modules/autoscaling"
  resource_group_name = var.resource_group_name
  location            = var.location
  vmss_id             = module.vmss.vmss_id
}

module "monitoring" {
  source                = "./modules/monitoring"
  resource_group_name   = var.resource_group_name
  location              = var.location
  target_resource_id    = module.compute.vm_id
}

module "defender" {
  source                     = "./modules/defender"
  subscription_id            = var.subscription_id
  log_analytics_workspace_id = module.monitoring.workspace_id
}

module "sentinel" {
  source                     = "./modules/sentinel"
  log_analytics_workspace_id = module.monitoring.workspace_id
}

module "policy" {
  source = "./modules/policy"
}

module "network_security" {
  source                    = "./modules/network-security"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  subnet_id                 = module.networking.subnet_id
  azure_firewall_subnet_id  = module.networking.azure_firewall_subnet_id
  public_ip_id              = module.bastion.public_ip_id
  storage_account_id        = var.storage_account_id
}

module "avd" {
  source              = "./modules/avd"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "domain_services" {
  source = "./modules/domain-services"
  vm_id  = module.compute.vm_id
}
