output "storage_account_id" {
  description = "Resource ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob endpoint URL"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}
