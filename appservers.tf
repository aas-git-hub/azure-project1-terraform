resource "azurerm_linux_virtual_machine_scale_set" "app_vmss" {
  name                = "${var.project_name}-app-vmss"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.app_vm_size
  instances           = var.app_instance_count
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  upgrade_mode        = "Manual"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "app-nic"
    primary = true

    ip_configuration {
      name                                   = "app-ipconfig"
      primary                                = true
      subnet_id                              = azurerm_subnet.app.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool.id]
    }
  }

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = var.ssh_public_key
  }

  disable_password_authentication = false

  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx
sed -i 's/80 default_server/8080 default_server/' /etc/nginx/sites-available/default
sed -i 's/80;$/8080;/' /etc/nginx/sites-available/default
systemctl restart nginx
EOF
  )
}
