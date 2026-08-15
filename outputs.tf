output "management_group_id" {
  description = "ID of the ALZ foundation management group."
  value       = azurerm_management_group.root.id
}

output "landing_zones_management_group_id" {
  description = "ID of the management group containing the subscription."
  value       = azurerm_management_group.child["landing_zones"].id
}