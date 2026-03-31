terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateaccountkt"
    container_name       = "tfstate"
    key                  = "infra.tfstate"
    use_azuread_auth     = true
  }
}
