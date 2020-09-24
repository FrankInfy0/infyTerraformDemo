# Configure the Microsoft Azure Provider
provider "azurerm" {
  version = "=2.26.0"

  subscription_id = var.subscription_id
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  client_secret   = var.client_secret
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

################ SPN Variables Begin ########################
variable "subscription_id" {}
variable "client_id" {}
variable "tenant_id" {}
variable "client_secret" {}
################ SPN Variables End ##########################

################ Key Vault Variables Begin ##################
variable "keyvault_name" {}
variable "keyvault_secret" {}
################ Key Vault Variables End ####################3
