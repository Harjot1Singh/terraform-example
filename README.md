# terraform-example

This repository contains an example terraform + terragrunt configuration to deploy infrastructure declaratively as code. 

View the accompanying blog post: http://harjot.me/blog/deploying-docker-containers-to-gke-using-terraform

The following prerequisites are required:

* Google Cloud Project per environment (development + production)
* Kubectl
* Terraform
* Terragrunt

The following will be deployed by the repo:

* [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine)
* Docker images onto Google Kubernetes Engine (`nginx`)
* A database provisioned by [Google Cloud SQL](https://cloud.google.com/sql)

## Structure

All terraform files in `terraform`. Usually, this would sit alongside application code.

`terraform/modules` contain Terraform-only reusable module definitions.

`terraform/live/[env]` contain subfolders for each service/infrastructure, each containing a `terragrunt.hcl` which reference the aforementioned modules.

## Usage

`cd` into `terraform/live/[development] or [production]` depending on the environment you'd like to work with. You can run `terragrunt plan-all` or `terragrunt apply-all`.


## Production Tips

These will be implemented in the future.

* [x] [Use a Cloud Proxy Sidecar](https://cloud.google.com/sql/docs/postgres/connect-kubernetes-engine) to allow your applications to interact with Cloud SQL.
* [ ] Use an Ingress Controller instead of exposing each service as a `LoadBalancer`. This way you have one central point of entry. The Traefik controller is great.