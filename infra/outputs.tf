output "ai_hub_id" {
  value = azapi_resource.ai_hub.id
}

output "ai_project_id" {
  value = azapi_resource.ai_project.id
}

output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}
