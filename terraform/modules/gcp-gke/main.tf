locals {
  network = "${var.cluster_name}-gke-network"
  subnet  = "${var.cluster_name}-gke-subnet"

  ip_range_pods     = "${var.cluster_name}-gke-pods"
  ip_range_services = "${var.cluster_name}-gke-services"
}

data "google_client_config" "default" {}

# Enable required account services
module "gcp_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 4.0"

  project_id = var.project_id

  disable_services_on_destroy = false
  disable_dependent_services  = false

  activate_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}

# Add a network
module "gcp_network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.4"

  project_id   = module.gcp_services.project_id
  network_name = local.network

  subnets = [
    {
      subnet_name   = local.subnet
      subnet_ip     = "10.0.0.0/17"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${local.subnet}" = [
      {
        range_name    = local.ip_range_pods
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = local.ip_range_services
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}

# Build a zonal cluster
module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 10.0"

  project_id     = module.gcp_network.project_id
  name           = var.cluster_name
  region         = var.region
  regional       = false
  zones          = var.zones
  network        = local.network
  subnetwork     = local.subnet
  network_policy = false

  ip_range_pods     = local.ip_range_pods
  ip_range_services = local.ip_range_services

  create_service_account     = false
  horizontal_pod_autoscaling = true

  remove_default_node_pool = true

  node_pools = [
    {
      name = "gke-pool"

      machine_type = var.machine_type
      preemptible  = var.preemptible

      initial_node_count = var.min_nodes
      min_count          = var.min_nodes
      max_count          = var.max_nodes

      disk_type    = var.disk_type
      disk_size_gb = var.disk_size


      auto_upgrade = true
    }
  ]
}
