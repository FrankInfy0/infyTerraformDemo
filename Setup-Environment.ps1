################################################# Environment Setup Begin ################################################################
# Setup Azure Environment
# Login to Azure using Group Admin Credentials
az login
az account list
az account set --subscription "de550458-e3ed-492f-941a-cab82ca7cbdf"
az account show

# Create Azure AD service principal in subscription <yourSubscriptionID>
az ad sp create-for-rbac --name="infyDemoSPN" --role="Contributor" --scopes="/subscriptions/de550458-e3ed-492f-941a-cab82ca7cbdf"

# Change these variables according to your needs
$RESOURCE_GROUP_NAME="infydemo-credinfo-rg"
$STORAGE_ACCOUNT_NAME="infydemociscldsa"
$STORAGE_CONTAINER_NAME="infydemociscldcontainer"
$KEYVAULT_NAME="infydemociscldkeyvault1"
$STORAGE_SECRET_NAME="infydemociscldsakvsecret"


# Create Resource Group, Storage Account and Container for Terraform backend (securely storing Terraform plan)
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
$STORAGE_ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $STORAGE_CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $STORAGE_ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $STORAGE_CONTAINER_NAME"
echo "access_key: $STORAGE_ACCOUNT_KEY"

# Create Azure KeyVault
az keyvault create -g $RESOURCE_GROUP_NAME --name $KEYVAULT_NAME 

# Set Azure KeyVault Secret value to storage account key
# Reference --> https://docs.microsoft.com/en-us/azure/key-vault/general/manage-with-cli2
az keyvault secret set --vault-name $KEYVAULT_NAME --name $STORAGE_SECRET_NAME --value $STORAGE_ACCOUNT_KEY
az keyvault secret list --vault-name $KEYVAULT_NAME

# Add SPN Account to the Secret Management Access Policy for the KeyVault