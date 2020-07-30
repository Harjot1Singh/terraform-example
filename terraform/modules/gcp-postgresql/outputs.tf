output "name" {
  description = "The name for Cloud SQL instance"
  value       = module.db.instance_name
}

output "psql_user_name" {
  description = "The user name for the default user"
  value       = random_password.user_name.result
  sensitive   = true
}

output "psql_user_pass" {
  description = "The password for the default user"
  value       = module.db.generated_user_password
  sensitive   = true
}

output "public_ip_address" {
  description = "The public IPv4 address assigned for the master instance"
  value       = module.db.public_ip_address
  sensitive   = true
}


output "connection_name" {
  description = "The connection name of the instance, used in Cloud SQL Proxy connection strings"
  value       = module.db.instance_connection_name
  sensitive   = true
}
