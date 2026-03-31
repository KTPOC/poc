
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

variable "appinsights_name" {
  description = "Application Insights name"
  type        = string
  default     = "appi-demo"
}
