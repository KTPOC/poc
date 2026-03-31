terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Use a recent 4.x version (the Foundry resources are documented in 4.x)
      version = ">= 4.54.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  storage_use_azuread = true
}
