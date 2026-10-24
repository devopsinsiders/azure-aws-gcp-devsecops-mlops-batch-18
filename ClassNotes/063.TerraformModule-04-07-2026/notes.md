# 📦 Terraform Modules: Architecture, Structure & Elimination of Code Duplication

> **Session Context:** Modularizing infrastructure code, DRY principles, child vs parent modules, and data block lookups.
> **Reference File:** `diagram.pdf`

---

## 1. The Problem with Monolithic Terraform Code ("Dards")

* **Repetitive Provider Blocks:** Repeating `provider "azurerm" {}` across multiple independent directories.
* **Lack of Standardization:** Different team members write resource definitions inconsistently.
* **No Reusability:** Copy-pasting 500 lines of VNet code across Dev, QA, and Prod environments creates maintenance nightmares.

---

## 2. Directory Structure: Child vs. Parent Modules

```
axion-terraform-landing-zone/
├── modules/                         # Reusable Child Modules
│   ├── azurerm_resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── azurerm_virtual_network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── azurerm_virtual_machine/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/                    # Parent Modules
    ├── dev/
    │   ├── main.tf                  # Calls modules using source = "../../modules/..."
    │   ├── terraform.tfvars
    │   └── provider.tf
    ├── qa/
    └── prod/
```

---

## 3. Data Blocks in Terraform

When a resource is already created (or managed outside the current module), we use `data` blocks to query its runtime attributes:

```hcl
data "azurerm_subnet" "frontend" {
  name                 = "frontend-subnet"
  virtual_network_name = "vnet-prod"
  resource_group_name  = "rg-prod"
}

# Use the retrieved ID in a NIC resource:
resource "azurerm_network_interface" "nic" {
  name                = "nic-frontend-01"
  location            = "centralindia"
  resource_group_name = "rg-prod"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
  }
}
```
