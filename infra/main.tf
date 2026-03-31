# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure AI Hub (Foundry)
resource "azurerm_ai_studio_hub" "hub" {
  name                = var.ai_hub_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Azure AI Project
resource "azurerm_ai_studio_project" "project" {
  name                = var.ai_project_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  hub_id              = azurerm_ai_studio_hub.hub.id
}

# Azure OpenAI Resource
resource "azurerm_cognitive_account" "openai" {
  name                = var.openai_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  kind     = "OpenAI"
  sku_name = "S0"
}

# OpenAI Deployment (GPT model)
resource "azurerm_cognitive_deployment" "gpt4" {
  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4"
    version = "0613"
  }

  scale {
    type = "Standard"
  }
}
