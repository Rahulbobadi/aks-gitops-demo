terraform {
  required_version = ">=1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.100"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tf-backend-rg"
    storage_account_name = "rahultfstate12345"
    container_name       = "tfstate"
    key                  = "aks-demo.tfstate"
  }
}

provider "azurerm" {
  features {}
}
