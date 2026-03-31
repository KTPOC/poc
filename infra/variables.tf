
variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
  default     = "rg-monitoring-demo"
}
]
variable "storage_account_name" {
  description = "Globally unique storage account name"
  type        = string
}
