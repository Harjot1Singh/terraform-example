provider "random" {
  version = "~> 2.3"
}

# Enable required account services
module "gcp_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 4.0"

  project_id = var.project_id

  disable_services_on_destroy = false
  disable_dependent_services  = false

  activate_apis = [
    "sqladmin.googleapis.com",
  ]
}

# Generate a random user name
resource "random_password" "user_name" {
  length  = 16
  special = false
}

# Create the Postgres instance
module "db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "~> 3.2"

  project_id = module.gcp_services.project_id

  name             = var.name
  user_name        = random_password.user_name.result
  database_version = "POSTGRES_12"

  zone      = var.zone
  region    = var.region
  disk_size = var.disk_size
  tier      = var.tier

  backup_configuration = {
    enabled    = var.enable_backups
    start_time = "04:00"
  }

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = false
    authorized_networks = var.authorized_networks
  }
}
