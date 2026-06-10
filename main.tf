#resource "azurerm_resource_group" "rg" {
#  name     = "aks-gitops-rg"
#  location = "Central India"
#}

resource "azurerm_container_registry" "acr" {
  name                = "aksgitopsacr12345"
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
    vm_size    = "Standard_B2s_V2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "demo"
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}