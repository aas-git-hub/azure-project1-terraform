resource "azurerm_public_ip" "bastion_pip" {
  name                = "${var.project_name}-bastion-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "bastion_nsg" {
  name                = "${var.project_name}-bastion-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# resource "azurerm_subnet_network_security_group_association" "bastion_assoc" {
#   subnet_id                 = azurerm_subnet.bastion.id
#   network_security_group_id = azurerm_network_security_group.bastion_nsg.id
# }

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.project_name}-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "config"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}
