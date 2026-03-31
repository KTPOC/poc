output "ai_hub_id" {
  value = azurerm_ai_studio_hub.hub.id
}

output "ai_project_id" {
  value = azurerm_ai_studio_project.project.id
}

output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}
