resource "azurerm_resource_group" "rg" {
  name     = "aks-gitops-rg3"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                = "aksgitopsacr127"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-gitops-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksgitops"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_V3"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "demo"
  }
}
