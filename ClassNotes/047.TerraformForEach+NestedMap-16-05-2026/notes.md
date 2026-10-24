# 📘 Terraform `for_each`, Map & Nested Map Deep Dive

> **Session Context:** Class session on advanced Terraform collections, data structures, `for_each` loops, nested maps, resource iteration, and DevSecOps interview preparation.
> **Reference File:** `diagram.pdf`

---

## 1. Overview & Architectural Mental Model

In production Terraform code, hardcoding multiple resource blocks is an anti-pattern. Instead, we use loops to provision scalable, dynamic infrastructure. Terraform provides the `for_each` meta-argument to iterate over collections (Sets and Maps).

### Key Rule:
* `count` is index-based (0, 1, 2...). If an element is removed from the middle, Terraform recreates resources.
* `for_each` is key-based. Each instance is bound to a distinct key (`each.key`). Modifying or removing a key only affects that specific resource!

---

## 2. Terraform Variable Types

```
                     Variables Types
                     /             \
           Singular                   Plural
          /   |    \                /      \
     String Number  Bool           List      Map
```

### 1. Singular Types (Single value)
* **String:** Text wrapped in double quotes (`"rg-prod"`, `"westus"`).
* **Number:** Numeric values without quotes (`54`, `87.5`).
* **Bool:** Logical boolean flags (`true` or `false`).

### 2. Plural Types (Collections)
* **List:** Ordered collection of the same data type:
  ```hcl
  lipistic_list = ["nykaa", "sugar", "lakme"]
  student_list  = ["adam", "ale", "tinku"]
  rgs           = ["rg-adam", "rg-ale", "rg-tinku"]
  locations     = ["westus", "eastus", "centralindia"]
  ```
* **Map:** Key-value pairs enclosed in curly braces `{}`.
  * **Rule:** Keys must ALWAYS be strings.
  * **Rule:** Values can be any data type (String, Number, Bool, List, or another Map).
  ```hcl
  # Simple Map (String -> String)
  rgs = {
    "rg-adam"  = "westus"
    "rg-ale"   = "eastus"
    "rg-tinku" = "centralindia"
  }

  # Simple Map (String -> Number)
  students_marks = {
    adam  = 54
    ale   = 87
    tinku = 94
  }
  ```

---

## 3. `for_each` with a Simple Map

When `for_each` is given a map, Terraform creates an instance of the resource block for every key in the map.

```hcl
resource "azurerm_resource_group" "rg" {
  for_each = {
    "rg-adam"  = "westus"
    "rg-ale"   = "eastus"
    "rg-tinku" = "centralindia"
  }

  name     = each.key    # "rg-adam", "rg-ale", "rg-tinku"
  location = each.value  # "westus", "eastus", "centralindia"
}
```

### Iteration Breakdown:
| Iteration | `each.key` | `each.value` | Created Resource |
| :--- | :--- | :--- | :--- |
| **Iteration 1** | `"rg-adam"` | `"westus"` | `azurerm_resource_group.rg["rg-adam"]` |
| **Iteration 2** | `"rg-ale"` | `"eastus"` | `azurerm_resource_group.rg["rg-ale"]` |
| **Iteration 3** | `"rg-tinku"` | `"centralindia"` | `azurerm_resource_group.rg["rg-tinku"]` |

> 💡 **Mental Model:** *"For_each utni baar fatega jitni foreach me keys hogi."* (Terraform will spawn exactly as many resource instances as there are top-level keys in the map).

---

## 4. Nested Maps ("Nakshe ke Andar Naksha")

A **Nested Map** is a map where the value for each key is another map (or map of objects). This is the gold standard for enterprise Terraform landing zones.

### Analogy:
```hcl
bfs = {
  "bf1" = {
    name   = "jhunjhun"
    height = 5.2
    colour = "brown"
  }
  "bf2" = {
    name   = "runjhun"
    height = 4.4
    colour = "white"
  }
}
```

### Production Example: Multi-Storage Account Deployment

#### Step 1: Define Input in `terraform.tfvars`
```hcl
storage_accounts = {
  sa1 = {
    name                     = "tinkustg"
    location                 = "eastus"
    resource_group_name      = "apple-rg"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
  sa2 = {
    name                     = "pinkustg"
    location                 = "westus"
    resource_group_name      = "banana-rg"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}
```

#### Step 2: Declare Variable in `variables.tf`
```hcl
variable "storage_accounts" {
  type = map(object({
    name                     = string
    location                 = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
  }))
}
```

#### Step 3: Implement Resource Block in `main.tf`
```hcl
resource "azurerm_storage_account" "storage_accounts" {
  for_each = var.storage_accounts

  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}
```

### How Terraform Resolves Iterations:
* **Iteration 1:**
  * `each.key` = `"sa1"`
  * `each.value.name` = `"tinkustg"`
  * `each.value.location` = `"eastus"`
  * `each.value.resource_group_name` = `"apple-rg"`
* **Iteration 2:**
  * `each.key` = `"sa2"`
  * `each.value.name` = `"pinkustg"`
  * `each.value.location` = `"westus"`
  * `each.value.resource_group_name` = `"banana-rg"`

---

## 5. DevSecOps Career & Interview Strategy

The board outlines strict guidelines for breaking into senior DevSecOps / Cloud roles:

1. **Hands-on Mastery:**
   * Build Resource Groups and Storage Accounts with nested maps within **30 minutes** independently without looking at notes.
   * Focus on Terraform and system design for the next 7 days without distractions.
2. **Resume Building with AI:**
   * Craft a high-impact, ATS-optimized resume using Claude AI.
   * Prominently showcase: **Azure, Terraform, Azure DevOps Pipelines, tfsec, trufflehog, terratest, super-linter, tflint, Docker, Kubernetes**.
3. **LinkedIn & Job Portals:**
   * Set LinkedIn to *"Open to Work"*.
   * Block your current employer on LinkedIn and job portals to prevent privacy conflicts.
   * Update your Naukri.com profile **4 times a day** (Morning, Afternoon, Evening, Night) to keep profile freshness at 100%.
4. **Mock Interviews & Mindset:**
   * Record your 5–7 minute self-introduction on video and review your body language.
   * Conduct mock interviews via video calls on peer platforms (e.g., Shiksha Sathi / MockBridge).
   * *"Direct kood jao kuye me"* — Preparation will never feel 100% complete; start interviewing and learning from failures!

---

## 6. Summary Cheat Sheet

| Syntax | Target Data Structure | Accessing Element |
| :--- | :--- | :--- |
| `for_each = toset(list)` | Set of Strings | `each.key` or `each.value` (identical) |
| `for_each = simple_map` | Key-Value Map | `each.key` = key, `each.value` = value |
| `for_each = nested_map` | Map of Objects | `each.key` = top-level key, `each.value.<property>` |
