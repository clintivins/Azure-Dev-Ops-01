output "storage_account_name" {
  description = "Storage account hosting Terraform remote state."
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Blob container for Terraform state files."
  value       = azurerm_storage_container.tfstate.name
}

output "resource_group_name" {
  description = "Resource group containing remote state storage."
  value       = var.resource_group_name
}
