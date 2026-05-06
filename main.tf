# 1. Networking Infrastructure (Must be first)
module "network" {
  source = "./modules/networking"

  # Dependencies defined via variables
  resource_group_name = var.resource_group_name
  location            = var.location
  # ... other inputs
}

# 2. Core Security Components (Key Vault, Monitoring)
module "keyvault" {
  source = "./modules/keyvault"

  # Key Vault depends on the RG created by the network module
  resource_group_name = var.resource_group_name
}

module "monitoring" {
  source = "./modules/monitoring"
  resource_group_name = var.resource_group_name
}

# 3. Network Security and Gateways
module "firewall" {
  source = "./modules/firewall"

  resource_group_name = var.resource_group_name

  # Uses the VNet/Subnets defined in the 'network' module
  hub_vnet_id = module.network.hub_vnet_id
}

# 4. AKS Clusters (Compute)
# Deployment 1 (Example: US-East)
module "aks_cluster_1" {
  source = "./modules/aks"

  cluster_name = "aks-us-east-1"
  location     = var.location_east
  network_id   = module.network.spoke1_vnet_id
  # ...
}

# Deployment 2 (Example: US-West)
module "aks_cluster_2" {
  source = "./modules/aks"

  cluster_name = "aks-us-west-1"
  location     = var.location_west
  network_id   = module.network.spoke2_vnet_id
  # ...
}

# 5. Load Balancing and Traffic Management
module "lb_regional" {
  source = "./modules/loadbalancer"

  resource_group_name = var.resource_group_name

  # Target must be the internal IP of the AKS Ingress/Load Balancer
  service_ip_address = module.aks_cluster_1.service_ip
}

module "traffic_manager" {
  source = "./modules/trafficmanager"

  # Traffic Manager uses the external public IPs/FQDNs from the Load Balancers
  ttl_seconds = 60

  endpoints = [
    {
      name        = "us-east"
      resource_id = module.lb_regional.public_ip_1
    }
    # ... second endpoint
  ]
}
