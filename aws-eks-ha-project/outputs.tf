output "east_cluster_name" {
  value = module.east_eks.cluster_name
}

output "west_cluster_name" {
  value = module.west_eks.cluster_name
}

output "east_cluster_endpoint" {
  value = module.east_eks.cluster_endpoint
}

output "west_cluster_endpoint" {
  value = module.west_eks.cluster_endpoint
}

output "east_cluster_arn" {
  value = module.east_eks.cluster_arn
}

output "west_cluster_arn" {
  value = module.west_eks.cluster_arn
}

output "transit_gateway_id" {
  value = module.transit_gateway.transit_gateway_id
}
