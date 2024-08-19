provider "azurerm" {
  features {}
}

# Define the Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-documentportal-container-resource-con"
  location = "eastus"
}

# Define the Linux App Service Plan for Containers
resource "azurerm_service_plan" "linux_plan" {
  name                = "rg-documentportal-linux-app-service-doccon"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Define the Container-based App Service
resource "azurerm_app_service" "container_service" {
  name                = "rg-documentportal-container-doccon"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.linux_plan.id

   app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "sgtrainingacr.azurecr.io"
    "DOCKER_REGISTRY_SERVER_USERNAME" = "sgtrainingacr"
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "YlQF0wFvoLNaPy4ibm4EcmYSHtTNnFFTS6perYo4Nj+ACRBs18c2"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
  site_config {
    linux_fx_version = "DOCKER|sgtrainingacr.azurecr.io/sgtrainingacr:Latest" # No Docker image specified
  }
}

# Output the URL
output "container_app_service_default_hostname" {
  value = azurerm_app_service.container_service.default_site_hostname
}