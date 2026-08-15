variable "subscription_id" {
  description = "Subscription that will be associated with the landing-zones management group."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID that owns the subscription."
  type        = string
}

variable "root_management_group_name" {
  description = "Name of the management group created below the tenant root."
  type        = string
  default     = "alz"
}

variable "location" {
  description = "Azure region reserved for future landing-zone resources."
  type        = string
  default     = "uksouth"
}