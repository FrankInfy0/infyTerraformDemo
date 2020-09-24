output "secret_value" {
  value = data.azurerm_key_vault_secret.mySecret.value
}


output "value" {
  value = data.aws_secretsmanager_secret_version.creds.secret_string
}