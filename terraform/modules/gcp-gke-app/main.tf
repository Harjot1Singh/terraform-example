provider "kubernetes" {
  load_config_file = false

  token                  = var.access_token
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.ca_certificate)
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "${var.name}-deployment"
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          name  = var.name
          image = var.image

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "100m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }

        dynamic "container" {
          for_each = var.enable_postgresql ? [var.enable_postgresql] : []

          content {
            name  = "cloud-sql-proxy"
            image = "gcr.io/cloudsql-docker/gce-proxy:1.17"
            command = [
              "/cloud_sql_proxy",
              "-instances=${var.postgresql_connection_name}=tcp:5432"
            ]

            resources {
              limits {
                cpu    = "0.5"
                memory = "512Mi"
              }

              requests {
                cpu    = "50m"
                memory = "50Mi"
              }
            }
          }
        }

      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name = var.name
  }

  spec {
    selector = {
      app = var.name
    }

    port {
      port        = var.port
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
