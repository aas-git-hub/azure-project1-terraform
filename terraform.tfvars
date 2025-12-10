azure_region      = "canadacentral"
project_name      = "banking3tier"
vm_admin_username = "azureadmin"

vm_admin_password  = "vm-@dm1n-p@ssw0rd!"
sql_admin_login    = "sqladminuser"
sql_admin_password = "sql-@dm1n-p@ssw0rd!"

dns_zone_name = "mybankapp-demo.com"
app_hostname  = "bankapp"

ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZivuUafqqBXgd+U2+W7ojRyTAJaGxYBgwQbWSKAhyqMl/A60UiIfu8S1YDW+1qZ3+hzwHMo4NcGTr0dDVLbSnt6Tu5zn0fMO3k6zpLmZOxMuDO774dUug3bDJwiJNEdseu6FpepchK2zwAKxkXnaCy8zm7ykR1lYXpEuluEdgcm6kLlKaLEyzM1ocrZqKcPoAbcSEtREjZBP6bBKFakqcd6V6qLFEwlF0MbDmt3kXEVWTRjQ74hF9zWMJwg4sVQo0VQCclyj3Fo08T2QaqWfkC9R99HQ+BFHbI8Wq+7REB0vCWJqJrRmP3xAEBDrWXV3pO2O2kbdvOn1Gbwz3yUiD6TsxBYibXKGfo4H/pjNkj3YxYHRNdai5pTjI0rkQN3vFmTiy3w/DKqILaoW2aHxZmNHoxII4zkYirsusPIvLX7BtH7dQ1cF/80pVCiUICkGkttZtPtpvn60KNaIS2RDKpH5lcT0AuoOkHNjpW3baj7wd2w/TkNncpxQZ8qKV0c+Pphr4/lAF42a8kLcH4omRjwaDgYGABz3IRfUbf00l3Uht+2uN/uPn67kgbZpKTIQD54gAEXC/DievXeSpKYBluy8hj02oiR1X6SeK7g/yPIV4gj/mwQssmCoY9sO8YKEhYEWtcJ6/L37m8vtK1MAoTHM+zwQ13fiP5C2/kv2fBw== novadina@yahoo.com"


web_vm_size        = "Standard_B1s"  # 1 vCPU
app_vm_size        = "Standard_B1s"  # 1 vCPU
web_instance_count = 1
app_instance_count = 1