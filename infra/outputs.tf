
output "appinsights_id" {
  value = azurerm_application_insights.appinsights.id
}

output "instrumentation_key" {
  value     = azurerm_application_insights.appinsights.instrumentation_key
  sensitive = true
}
