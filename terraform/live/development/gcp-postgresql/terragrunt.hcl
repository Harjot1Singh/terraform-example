include {
  path = find_in_parent_folders()
}

locals {
  env    = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).locals
}

terraform {
  source = "../../../modules/gcp-postgresql"
}

dependency "gke" {
  config_path = "../gcp-gke"
}

inputs = {
  project_id = local.env.project

  name   = join("-", [local.common.org, local.env.env])
  region = local.env.region
  zone   = "b"

  tier = "db-f1-micro"

  enable_backups = false
}
