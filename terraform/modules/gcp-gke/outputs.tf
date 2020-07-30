output "cluster_endpoint" {
  description = "The IP address of the cluster master"
  sensitive   = true
  value       = module.gke.endpoint
}

output "cluster_name" {
  description = "The name of the cluster master"
  sensitive   = true
  value       = module.gke.name
}

output "ca_certificate" {
  description = "The public certificate that is the root of trust for the cluster"
  sensitive   = true
  value       = module.gke.ca_certificate
}

output "access_token" {
  description = "The access token to authenticate with the cluster"
  sensitive   = true
  value       = data.google_client_config.default.access_token
}

output "network_name" {
  description = "The name of the VPC being created"
  value       = module.gcp_network.network_name
}

output "subnet_name" {
  description = "The name of the subnet being created"
  value       = module.gcp_network.subnets_names
}

output "subnet_secondary_ranges" {
  description = "The secondary ranges associated with the subnet"
  value       = module.gcp_network.subnets_secondary_ranges
}
