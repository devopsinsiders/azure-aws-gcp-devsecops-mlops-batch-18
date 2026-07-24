data "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machines
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}
