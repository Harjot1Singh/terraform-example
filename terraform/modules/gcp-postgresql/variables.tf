variable "project_id" {
  description = "The project ID to manage the Cloud SQL resource"
  type        = string
}

variable "name" {
  description = "The name of the Cloud SQL resource"
  type        = string
}

variable "region" {
  description = "The region of the Cloud SQL resource"
  type        = string
}

variable "tier" {
  description = "The tier for the master instance"
  type        = string
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `a`, `c`"
  type        = string
}

variable "disk_size" {
  description = "The disk size for the master instance"
  type        = number
  default     = 10
}

variable "authorized_networks" {
  description = "List of mapped public networks authorized to access to the instances"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "enable_backups" {
  description = "Whether backups are enabled or not"
  type        = bool
  default     = true
}
