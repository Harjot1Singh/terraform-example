output "public_ip" {
  description = "The public IP address of the exposed app"
  value = kubernetes_service.service.load_balancer_ingress[0].ip
}