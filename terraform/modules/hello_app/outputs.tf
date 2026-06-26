output "service_name" {
  description = "Kubernetes Service name for the hello app."
  value       = kubernetes_service.hello.metadata[0].name
}

output "namespace" {
  description = "Kubernetes namespace hosting the hello app."
  value       = var.namespace
}

output "load_balancer_ip" {
  description = "Public IP assigned to the hello app LoadBalancer service, if available."
  value = try(
    kubernetes_service.hello.status[0].load_balancer[0].ingress[0].ip,
    null
  )
}
