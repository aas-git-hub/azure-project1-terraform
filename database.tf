resource "azurerm_mssql_server" "primary" {
  name                         = "${var.project_name}-sql-primary"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_server" "secondary" {
  name                         = "${var.project_name}-sql-secondary"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "primary_db" {
  name      = "${var.project_name}-db"
  server_id = azurerm_mssql_server.primary.id
  sku_name  = "S0"
}

resource "azurerm_mssql_failover_group" "fg" {
  name      = "${var.project_name}-fg"
  server_id = azurerm_mssql_server.primary.id
  databases = [azurerm_mssql_database.primary_db.id]

  partner_server {
    id = azurerm_mssql_server.secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
}

