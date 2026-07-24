module "rg" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.rgs
}

module "vnet" {
  depends_on       = [module.rg]
  source           = "../../modules/azurerm_virtual_network"
  virtual_networks = var.vnets
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../modules/azurerm_subnet"
  subnets    = var.snets
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.pips
}

module "nics" {
  depends_on         = [module.pip, module.subnet]
  source             = "../../modules/azurerm_network_interface"
  network_interfaces = var.nics
}

module "vms" {
  depends_on       = [module.nics]
  source           = "../../modules/azurerm_linux_virtual_machine"
  virtual_machines = var.vms
}
