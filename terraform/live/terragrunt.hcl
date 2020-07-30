locals {
  # Load any configured variables
  env    = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).locals
}

# Configure Terragrunt to store state in GCP buckets
remote_state {
  backend = "gcs"

  config = {
    bucket      = join("-", [local.common.org, local.env.env, "--terraform-state"])
    prefix      = "${path_relative_to_include()}"
    credentials = local.env.credentials_path
    location    = local.env.region
    project     = local.env.project
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  version = "~> 3.16.0"

  credentials = "${local.env.credentials_path}"
  project     = "${local.env.project}"
  region      = "${local.env.region}"
}

provider "google-beta" {
  credentials = "${local.env.credentials_path}"
  project     = "${local.env.project}"
  region      = "${local.env.region}"
}
  EOF
}

inputs = merge(
  local.env,
  local.common,
)
