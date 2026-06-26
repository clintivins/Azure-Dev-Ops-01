variable "subscription_id" {
  type        = string
  description = "Azure subscription ID for the DevOps landing zone."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group that hosts Terraform remote state storage."
}

variable "location" {
  type        = string
  description = "Azure region for state storage."
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name for Terraform state."

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 lowercase alphanumeric characters."
  }
}

variable "container_name" {
  type        = string
  description = "Blob container used for Terraform state files."
  default     = "tfstate"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to bootstrap resources."
  default     = {}
}
