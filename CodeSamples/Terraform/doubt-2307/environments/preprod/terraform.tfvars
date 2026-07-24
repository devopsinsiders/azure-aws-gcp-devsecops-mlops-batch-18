rgs = {
  rg1 = {
    name     = "rg-dhondhu"
    location = "centralindia"
  }
}

vnets = {
  vnet1 = {
    name                = "vnet-dhondhu"
    location            = "centralindia"
    resource_group_name = "rg-dhondhu"
    address_space       = ["10.0.0.0/16"]
  }
}

snets = {
  frontend_snet = {
    name                 = "frontend-subnet"
    resource_group_name  = "rg-dhondhu"
    virtual_network_name = "vnet-dhondhu"
    address_prefixes     = ["10.0.1.0/24"]
  }
  backend_snet = {
    name                 = "backend-subnet"
    resource_group_name  = "rg-dhondhu"
    virtual_network_name = "vnet-dhondhu"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

pips = {
  pip1 = {
    name                = "pip1"
    location            = "centralindia"
    resource_group_name = "rg-dhondhu"
    allocation_method   = "Static"
  }
}

nics = {
  nic1 = {
    name                 = "dhondhu-nic-1"
    location             = "centralindia"
    resource_group_name  = "rg-dhondhu"
    subnet_name          = "frontend-subnet"
    public_ip_name       = "pip1"
    virtual_network_name = "vnet-dhondhu"
  }
}

vms = {
  vm1 = {
    vm_name             = "dhondhu-frontend-vm"
    location            = "centralindia"
    resource_group_name = "rg-dhondhu"
    size                = "Standard_B1s"
    admin_username      = "devopsadmin"
    admin_password      = "Dhondhu@123"
    nic_name            = "dhondhu-nic-1"
  }
}
