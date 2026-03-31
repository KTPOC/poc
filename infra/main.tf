resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}



data "azurerm_client_config" "current" {}

# ----------------------------
# Resource Group
# ---------------------------

# ----------------------------
# Key Vault (required by Foundry Hub)
# ----------------------------
resource "azurerm_key_vault" "kv" {
  name                = "kv-aifoundry-demo-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"

  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Get",
    "Delete",
    "Purge",
    "GetRotationPolicy",
  ]
}

# ----------------------------
# Storage Account (required by Foundry Hub)
# ----------------------------
resource "azurerm_storage_account" "sa" {
  name                     = "stfoundrydemo001" # must be globally unique (lowercase, 3-24 chars)
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

# ----------------------------
# AI Services resource (required by Foundry Hub example)
# ----------------------------
resource "azurerm_ai_services" "ais" {
  name                = "aiservices-foundry-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "S0"
}

# ----------------------------
# AI Foundry Hub
# ----------------------------
resource "azurerm_ai_foundry" "hub" {
  name                = "aifoundry-hub-demo"
  location            = azurerm_ai_services.ais.location
  resource_group_name = azurerm_resource_group.rg.name

  storage_account_id = azurerm_storage_account.sa.id
  key_vault_id       = azurerm_key_vault.kv.id

  identity {
    type = "SystemAssigned"
  }
}

# ----------------------------
# AI Foundry Project
# ----------------------------
resource "azurerm_ai_foundry_project" "project" {
  name            = "aifoundry-project-demo"
  location        = azurerm_ai_foundry.hub.location
  ai_services_hub_id = azurerm_ai_foundry.hub.id
}
