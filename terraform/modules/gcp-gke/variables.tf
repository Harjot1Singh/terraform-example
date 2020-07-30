variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "cluster_name" {
  description = "The name for the GKE cluster"
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "zones" {
  description = "The zones to host the cluster in"
  type        = list(string)
}

variable "machine_type" {
  description = "The machine type for nodes in the node pool"
  type        = string
}

variable "min_nodes" {
  description = "The minimum number of nodes in the node pool"
  default     = 1
  type        = number
}

variable "max_nodes" {
  description = "The maximum number of nodes in the node pool"
  type        = number
}

variable "disk_type" {
  description = "The type of disk"
  type        = string
  default     = "pd-standard"
}

variable "disk_size" {
  description = "The size of each node's disk (GB)"
  type        = number
  default     = 100
}

variable "preemptible" {
  description = "Whether nodes are premptible or not"
  type        = bool
  default     = false
}
