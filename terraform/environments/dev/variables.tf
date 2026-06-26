variable "subscription_id" {
  type        = string
  description = "Azure subscription ID."
}

variable "resource_group_name" {
  type        = string
  description = "Application resource group name for the dev environment."
}

variable "location" {
  type        = string
  description = "Azure region for dev resources."
}

variable "aks_cluster_name" {
  type        = string
  description = "AKS cluster name."
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS API server."
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the default AKS node pool."
}

variable "aks_vm_size" {
  type        = string
  description = "VM size for AKS nodes."
}

variable "app_name" {
  type        = string
  description = "Kubernetes application name."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to dev resources."
  default     = {}
}
