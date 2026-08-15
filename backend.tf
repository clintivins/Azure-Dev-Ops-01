terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devops-clintivinsicloud"
    storage_account_name = "sttfdevcursororg01"
    container_name       = "tfstate"
    key                  = "azure-landing-zone.tfstate"
  }
}