terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "app" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  dns_prefix          = var.aks_dns_prefix
  sku_tier            = "Free"

  tags = var.tags

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.app.kube_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.app.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.app.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.app.kube_config[0].cluster_ca_certificate)
}

module "hello_app" {
  source = "../../modules/hello_app"

  app_name = var.app_name
  app_html = file("${path.module}/../../../apps/hello-world/index.html")

  depends_on = [azurerm_kubernetes_cluster.app]
}
