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
