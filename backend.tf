# https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#:~:text=%20Tutorial%3A%20Store%20Terraform%20state%20in%20Azure%20Storage,This%20pattern...%205%20Next%20steps.%20%20More

######################## Azure Storage Account Begin ###########################################
terraform {
  backend "azurerm" {
    resource_group_name  = "infydemo-credinfo-rg"
    storage_account_name = "infydemociscldsa"
    container_name       = "infydemociscldcontainer"
    key                  = "infydemo-terraform.tfstate"
  }
}
######################## Azure Storage Account End ############################################

################################# Key Vault Begin #############################################
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = "infydemo-credinfo-rg"
}

data "azurerm_key_vault_secret" "mySecret" {
  name         = var.keyvault_secret
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
################################### Key Vault End ##############################################


######################## AWS Secret Manager Begin ############################################
data "aws_secretsmanager_secret_version" "creds" {
  # Fill in the name you gave to your secret
  secret_id = "azurevmpassword"
}
######################## Azure Storage Account End ###########################################
