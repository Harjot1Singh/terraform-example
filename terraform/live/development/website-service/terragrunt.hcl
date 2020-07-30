include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/gcp-gke-app"
}

dependency "gke" {
  config_path = "../gcp-gke"
}

inputs = {
  cluster_endpoint = dependency.gke.outputs.cluster_endpoint
  ca_certificate   = dependency.gke.outputs.ca_certificate
  access_token     = dependency.gke.outputs.access_token

  name  = "nginx"
  image = "nginx"

  port = 8080
}
