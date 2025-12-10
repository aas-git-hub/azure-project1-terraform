# Public IP for frontend (internet-facing) load balancer
resource "azurerm_public_ip" "frontend_pip" {
  name                = "${var.project_name}-fe-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Frontend (public) load balancer
resource "azurerm_lb" "frontend_lb" {
  name                = "${var.project_name}-fe-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.frontend_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "frontend_pool" {
  name            = "fe-backend-pool"
  loadbalancer_id = azurerm_lb.frontend_lb.id
}

resource "azurerm_lb_probe" "frontend_http_probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.frontend_lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "frontend_http_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.frontend_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicFrontend"
  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.frontend_pool.id
  ]
  probe_id = azurerm_lb_probe.frontend_http_probe.id
}

# Internal backend load balancer (between web and app tiers)
resource "azurerm_lb" "backend_lb" {
  name                = "${var.project_name}-be-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "InternalFrontend"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "be-backend-pool"
  loadbalancer_id = azurerm_lb.backend_lb.id
}

resource "azurerm_lb_probe" "backend_http_probe" {
  name                = "be-http-probe"
  loadbalancer_id     = azurerm_lb.backend_lb.id
  protocol            = "Tcp"
  port                = 8080
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "backend_http_rule" {
  name                           = "be-http-rule"
  loadbalancer_id                = azurerm_lb.backend_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "InternalFrontend"
  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.backend_pool.id
  ]
  probe_id = azurerm_lb_probe.backend_http_probe.id
}
