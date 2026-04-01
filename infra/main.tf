resource "azurerm_resource_group" "rg" {
  name     = "rg-ai-foundry-prod"
  location = "eastus"
}

module "openai" {
  source  = "Azure/avm-res-cognitiveservices-account/azurerm"
  version = "~> 0.3.0"

  name                = "openai-prod-demo-12345"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  kind     = "OpenAI"
  sku_name = "S0"

  # 🔐 Security Best Practices
  public_network_access_enabled = false

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    environment = "prod"
    workload    = "ai-foundry"
  }
}
resource "azurerm_cognitive_deployment" "gpt" {
  name                 = "gpt-deployment"
  cognitive_account_id = module.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4.1-mini"   # ✅ VALID model
    version = "2025-01-01"
  }

  scale {
    type = "Standard"
  }
}
