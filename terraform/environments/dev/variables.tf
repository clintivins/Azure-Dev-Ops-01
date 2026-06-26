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

variable "tags" {
  type        = map(string)
  description = "Tags applied to dev resources."
  default     = {}
}
