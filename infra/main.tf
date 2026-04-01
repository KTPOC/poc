resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "openai" {
  source  = "Azure/avm-res-cognitiveservices-account/azurerm"
  version = "~> 0.3.0"

  name                = var.openai_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = "OpenAI"
  sku_name = "S0"

  # 🔐 Security best practice
  public_network_access_enabled = true  # set false after private endpoint

  identity = {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# ✅ Model Deployment (IMPORTANT)
resource "azurerm_cognitive_deployment" "gpt" {
  name                 = "gpt-deployment"
  cognitive_account_id = module.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4.1-mini"
    version = "2025-01-01"
  }

  scale {
    type = "Standard"
  }
}
