# 🔍 Terraform Data Blocks: Dynamic Subnet Querying & Resource Binding

> **Session Context:** Decoupling infrastructure resources using Terraform `data` blocks, dynamic subnet resolution, and map-driven NIC provisioning.
> **Reference File:** `diagram.pdf`

---

## 1. What is a Terraform Data Block?

While a `resource` block instructs Terraform to create, update, or delete cloud infrastructure, a `data` block queries existing cloud resources to read their attributes without managing their lifecycle.

```
+-------------------------------------------------------------+
| Existing Subnet in Azure (Pre-created by Networking Team)   |
| Name: "frontend-subnet", VNet: "vnet-prod", RG: "rg-prod"   |
+------------------------------+------------------------------+
                               ^
                               | data "azurerm_subnet" queries ID
+------------------------------+------------------------------+
| azurerm_network_interface (Managed by Compute Team)         |
| subnet_id = data.azurerm_subnet.subnet["nic1"].id          |
+-------------------------------------------------------------+
```

---

## 2. Hands-on Code Implementation

### Defining NIC Configuration in `terraform.tfvars`:
```hcl
nics = {
  nic1 = {
    nic_name        = "frontend-vm-nic"
    nic_location    = "centralindia"
    nic_rg_name     = "rg-prod"
    nic_vnet_name   = "vnet-prod"
    nic_subnet_name = "frontend-subnet"
  }
}
```

### Dynamic Subnet Resolution via Data Block:
```hcl
data "azurerm_subnet" "subnet" {
  for_each             = var.nics
  name                 = each.value.nic_subnet_name
  virtual_network_name = each.value.nic_vnet_name
  resource_group_name  = each.value.nic_rg_name
}
```

### NIC Resource referencing the Data Block Output:
```hcl
resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.nic_location
  resource_group_name = each.value.nic_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
```

### Why This is an Enterprise Best Practice:
* Eliminates hardcoded Subnet Resource IDs.
* Decouples the networking team's codebase from the compute team's codebase.
