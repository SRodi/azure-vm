variable "subscription_id" {
  description = "The subscription ID for the Azure account."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure account."
  type        = string
}

variable "location" {
  description = "The VM location."
  type        = string
  default     = "UK South"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "prefix" {
  description = "A prefix to add to all resources."
  type        = string
  default     = "example-vm"
}

variable "path_to_public_key" {
  description = "The path to the public key to use for SSH."
  type        = string
}