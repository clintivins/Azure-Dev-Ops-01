locals {
  management_groups = {
    platform      = "Platform"
    landing_zones = "Landing Zones"
    sandbox       = "Sandbox"
  }
}

resource "azurerm_management_group" "root" {
  display_name = var.root_management_group_name
  name         = var.root_management_group_name
}

resource "azurerm_management_group" "child" {
  for_each = local.management_groups

  display_name               = each.value
  name                       = "${var.root_management_group_name}-${each.key}"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group_subscription_association" "landing_zone" {
  management_group_id = azurerm_management_group.child["landing_zones"].id
  subscription_id     = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "allowed-locations"
  display_name         = "Allowed locations"
  management_group_id  = azurerm_management_group.child["landing_zones"].id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = [var.location]
    }
  })
}