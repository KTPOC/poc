# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# ---------------------------
# AI HUB (Foundry) via AzAPI
# ---------------------------
resource "azapi_resource" "ai_hub" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01"
  name      = var.ai_hub_name
  location  = var.location
  parent_id = azurerm_resource_group.rg.id
identity {
    type = "SystemAssigned"
  }


  body = jsonencode({
    kind = "Hub"
    properties = {}
  })
}


# ---------------------------
# AI PROJECT
# ---------------------------
resource "azapi_resource" "ai_project" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01"
  name      = var.ai_project_name
  location  = var.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = jsonencode({
    kind = "Project"
    properties = {
      hubResourceId = azapi_resource.ai_hub.id
    }
  })
}

# ---------------------------
# Azure OpenAI
# ---------------------------
resource "azurerm_cognitive_account" "openai" {
  name                = var.openai_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  kind     = "OpenAI"
  sku_name = "S0"
}

# ---------------------------
# Model Deployment
# ---------------------------
resource "azurerm_cognitive_deployment" "gpt4" {
  name                 = "gpt-4o-mini"
  cognitive_account_id = azurerm_cognitive_account.openai.id


 model {
  format  = "OpenAI"
  name    = var.openai_model_name
}

  scale {
    type = "Standard"
  }
}
