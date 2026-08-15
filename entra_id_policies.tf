locals {
  entra_id_platform_policy_parameters = jsonencode({
    effect = {
      type          = "String"
      metadata      = { displayName = "Effect" }
      allowedValues = ["Audit", "Disabled"]
      defaultValue  = "Audit"
    }
  })
}

resource "azurerm_policy_definition" "audit_managed_identity" {
  name                = "audit-managed-identity"
  display_name        = "Audit platform resources without managed identity"
  description         = "Audits selected platform resources that do not have a system-assigned managed identity for Entra ID-based authentication."
  management_group_id = azurerm_management_group.child["platform"].id
  policy_type         = "Custom"
  mode                = "Indexed"
  parameters          = local.entra_id_platform_policy_parameters

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          in    = ["Microsoft.Automation/automationAccounts", "Microsoft.ContainerRegistry/registries", "Microsoft.KeyVault/vaults"]
        },
        {
          field       = "identity.type"
          notContains = "SystemAssigned"
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_policy_definition" "audit_key_vault_rbac" {
  name                = "audit-key-vault-rbac"
  display_name        = "Audit Key Vaults using Entra ID RBAC"
  description         = "Audits Key Vaults that are not configured to authorize data-plane access with Azure role-based access control."
  management_group_id = azurerm_management_group.child["platform"].id
  policy_type         = "Custom"
  mode                = "Indexed"
  parameters          = local.entra_id_platform_policy_parameters

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.KeyVault/vaults"
        },
        {
          field  = "Microsoft.KeyVault/vaults/enableRbacAuthorization"
          equals = false
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "audit_managed_identity" {
  name                 = "audit-managed-identity"
  display_name         = "Audit platform resources without managed identity"
  management_group_id  = azurerm_management_group.child["platform"].id
  policy_definition_id = azurerm_policy_definition.audit_managed_identity.id
  parameters           = jsonencode({ effect = { value = "Audit" } })
}

resource "azurerm_management_group_policy_assignment" "audit_key_vault_rbac" {
  name                 = "audit-key-vault-rbac"
  display_name         = "Audit Key Vaults using Entra ID RBAC"
  management_group_id  = azurerm_management_group.child["platform"].id
  policy_definition_id = azurerm_policy_definition.audit_key_vault_rbac.id
  parameters           = jsonencode({ effect = { value = "Audit" } })
}