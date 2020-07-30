variable "cluster_endpoint" {
  description = "The Kubernetes endpoint"
  type        = string
}

variable "access_token" {
  description = "The access token to authenticate with the Kubernetes cluster"
  type        = string
}

variable "ca_certificate" {
  description = "The cluster's certificate for authentication"
  type        = string
}

variable "name" {
  description = "The name of the deployment"
  type        = string
}

variable "image" {
  description = "The image to deploy"
  type        = string
}

variable "replicas" {
  description = "The number of replicas"
  type        = number
  default     = 1
}

variable "port" {
  description = "The port to expose the application on"
  type        = number
}

variable "enable_postgresql" {
  description = "Enables PostgreSQL support via a Cloud Proxy Sidecar"
  type        = bool
  default     = false
}

variable "postgresql_connection_name" {
  description = "The Cloud SQL connection name for a PostgreSQL database"
  type        = string
  default     = null
}
