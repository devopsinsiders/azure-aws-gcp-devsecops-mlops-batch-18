# 📘 Terraform Complete Architecture & State Recap

> **Session Context:** Comprehensive recap session covering Terraform binary architecture, state file lifecycle, 3-way synchronization, variable hierarchies, loops, and child/parent modules.
> **Reference File:** `diagram.pdf`

---

## 1. Terraform Binary Architecture

Terraform is an Infrastructure as Code (IaC) tool designed to manage multi-cloud infrastructure declaratively.

```
                  +-------------------+
                  |   terraform.exe   | (Terraform Core Engine)
                  +---------+---------+
                            | RPC / Plugin Interface
        +-------------------+-------------------+
        |                   |                   |
+-------v-------+   +-------v-------+   +-------v-------+
|  azurerm.exe  |   |    aws.exe    |   |  google.exe   | (Provider Plugins)
+-------+-------+   +---------------+   +---------------+
        | Azure REST APIs / az cli
+-------v-------+
|  Azure Cloud  |
+---------------+
```

* `terraform.exe`: Parses `.tf` configuration, builds dependency graphs, and tracks state.
* `azurerm.exe`: The Azure provider plugin that translates HCL resource blocks into Azure Resource Manager (ARM) REST API calls.

---

## 2. Core Rule: One Block = One Cloud Resource

* **1 Resource Block** = **1 Cloud Resource**.
  * 1 Resource Group = 1 `azurerm_resource_group` block.
  * 1 Storage Account = 1 `azurerm_storage_account` block.
* To create multiple resources without duplicating code blocks, we **must use loops** (`for_each`).

---

## 3. Terraform State Lifecycle: "Code Hi Satya Hai"

Terraform relies on three states of the universe:
1. **Desired State (Code):** Defined in `.tf` files (*Source of Truth*).
2. **Current Cloud State (Cloud/Azure):** Actual resources deployed in Azure.
3. **Recorded State (`terraform.tfstate`):** JSON metadata file tracking resource mappings.

```
            [ 1. Refresh ]
 Cloud/Azure -------------> State File
      ^                          |
      |                          | [ 2. Compare ]
      |                          v
      +------------------- Code (.tf)
           [ 3. Apply ]
```

### The Golden Rule of State:
> ⚠️ **"State file ko kholna paap hai."** (Never manually edit `terraform.tfstate`. Always use CLI commands like `terraform state list`, `terraform state show`, `terraform state rm`, or `terraform import`).

### Three Core Reconciliation Scenarios:
| Scenario | What Happened | Terraform Plan Action |
| :--- | :--- | :--- |
| **Scenario 1** | A new resource block is added to code | **1 to add** |
| **Scenario 2** | An existing resource block is deleted from code | **1 to destroy** |
| **Scenario 3** | An engineer manually deletes a resource in the Azure Portal | On refresh, state detects absence: **1 to add** (re-creates it to match code) |

---

## 4. Terraform Variables: 3-Phase Lifecycle

1. **Declare:** In `variables.tf` (`variable "name" {}`)
2. **Assign:** In `terraform.tfvars`, `-var`, environment variables, or CLI prompts (6 methods of assignment)
3. **Use:** In `main.tf` using `var.<variable_name>`

### Data Types Overview:
* **Singular:** `string` (`"jhunjhuna"`), `number` (`6.1`), `bool` (`true`/`false`).
* **Plural:**
  * **List:** Ordered collection, allows duplicates (`["a", "b", "a"]`).
  * **Set:** Unordered collection, strictly unique elements (no duplicates). Converted using `toset()`.
  * **Map:** Key-value pairs (`{ key = value }`), where keys are always strings.
  * **Nested Map:** Map containing objects/maps with distinct fields.

---

## 5. Iterations with `for_each`

### Case A: `for_each` with a Set
```hcl
resource "azurerm_resource_group" "rg1" {
  for_each = toset(["bambaiya-rg", "rasogolla-rg"])
  name     = each.value
  location = "westus"
}
```

### Case B: `for_each` with a Nested Map
```hcl
resource "azurerm_storage_account" "example" {
  for_each = {
    tinku-storage123 = {
      rg_name     = "apple-rg"
      jagah       = "westus"
      tier        = "Standard"
      redundancy  = "LRS"
    }
    pinku-storage123 = {
      rg_name     = "banana-rg"
      jagah       = "eastus"
      tier        = "Standard"
      redundancy  = "GRS"
    }
  }

  name                     = each.key
  resource_group_name      = each.value.rg_name
  location                 = each.value.jagah
  account_tier             = each.value.tier
  account_replication_type = each.value.redundancy
}
```

### Visualization Checklist for Loops:
When troubleshooting `for_each`:
1. What is passed into `for_each`? Is it a Set or a Map?
2. If it is a List/Set, how many elements are there?
3. If it is a Map, how many **top-level keys** are present?
4. **Number of top-level keys = Number of iterations/resources created.**

---

## 6. Child & Parent Modules

```
                 +-------------------+
                 |   Parent Module   |  (root main.tf)
                 +---------+---------+
                           |
        +------------------+------------------+
        | calls                               | calls
+-------v-------+                     +-------v-------+
|  Child Module |                     |  Child Module |
|  (Resource    |                     |  (Storage     |
|   Group)      |                     |   Account)    |
+---------------+                     +---------------+
```

* **Child Module:** Reusable infrastructure code in its own directory containing `main.tf`, `variables.tf`, and `outputs.tf`.
* **Parent Module:** Calls child modules, sets parameters, and controls multi-environment deployments.
* **Implicit Dependency:** Resources within the same module automatically infer dependencies when referencing attributes (e.g. `azurerm_resource_group.rg.name`).

---

## 7. Action Plan & Learning Practice
* Practice creating Resource Group and Storage Account modules **at least 10 times manually**.
* Screen-share and teach the architecture to at least 10 peers.
* Master the first 10 foundational Azure resources by hand before accelerating with AI tools (Gemini CLI / Claude Code).
