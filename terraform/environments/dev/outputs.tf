output "resource_group_name" {
  description = "Dev application resource group name."
  value       = azurerm_resource_group.app.name
}

output "resource_group_id" {
  description = "Dev application resource group ID."
  value       = azurerm_resource_group.app.id
}

output "location" {
  description = "Azure region for dev resources."
  value       = azurerm_resource_group.app.location
}

output "aks_cluster_name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.app.name
}

output "aks_kube_config" {
  description = "Sensitive kubeconfig for the AKS cluster."
  value       = azurerm_kubernetes_cluster.app.kube_config_raw
  sensitive   = true
}

output "app_service_name" {
  description = "Kubernetes service name for the hello app."
  value       = module.hello_app.service_name
}

output "app_url" {
  description = "Public URL for the hello app once the LoadBalancer IP is assigned."
  value       = module.hello_app.load_balancer_ip != null ? "http://${module.hello_app.load_balancer_ip}" : "pending"
}
