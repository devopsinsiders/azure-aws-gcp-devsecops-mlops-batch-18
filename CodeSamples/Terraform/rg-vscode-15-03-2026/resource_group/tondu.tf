terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.64.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1075ec7a-b17a-4f37-bf3f-9d68c4506dc1"
}

resource "azurerm_resource_group" "choudhary" {
  name     = "chapri1"
  location = "West Europe"
}