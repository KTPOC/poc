terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateaccount12345"
    container_name       = "tfstate"
    key                  = "appinsights.tfstate"
    use_azuread_auth     = true
  }
}
