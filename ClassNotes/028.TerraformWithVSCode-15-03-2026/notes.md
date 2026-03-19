
# 🚀 Terraform + Azure Resource Group (RG) – Complete Notes

## 📌 1. Requirement

* Goal: **Create an Azure Resource Group (RG)**

---

## ⚙️ 2. Ways to Create Resources

### 🔹 Manual vs Automation

| Type           | Description                              |
| -------------- | ---------------------------------------- |
| **Manual**     | Create resources using Azure Portal (UI) |
| **Automation** | Use scripts/tools to create resources    |

---

### 🔹 Imperative vs Declarative

| Type            | Approach                  | Example               |
| --------------- | ------------------------- | --------------------- |
| **Imperative**  | Step-by-step instructions | Azure CLI, PowerShell |
| **Declarative** | Define desired state      | Terraform             |

👉 **Key Difference:**

* Imperative = *“How to do”*
* Declarative = *“What you want”*

---

## 🛠️ 3. Tools Used

### 🔹 Imperative Tools

* **Azure CLI (`az cli`)**
* **PowerShell**

👉 Example (Azure CLI):

```bash
az group create --name myRG --location eastus
```

👉 Example (PowerShell):

```powershell
New-AzResourceGroup -Name myRG -Location eastus
```

---

### 🔹 Declarative Tool

* **Terraform**

👉 Uses `.tf` files to define infrastructure

---

## 📂 4. File-Based Approach (Terraform)

| Concept   | Description         |
| --------- | ------------------- |
| File      | `.tf` file          |
| Content   | Resource definition |
| Execution | Terraform commands  |

---

## 🔍 5. How to Search Terraform Code

Use this syntax in Google:

```
<CLOUD> <RESOURCE> terraform
```

👉 Example:

```
azure resource group terraform
```

👉 This leads to:

* Terraform Registry (official docs)

---

## 📚 6. Terraform Registry

* Official documentation for Terraform resources
* Contains:

  * Syntax
  * Arguments
  * Examples

---

## 🧱 7. Terraform Code Structure

### 🔹 Basic Block Syntax

```hcl
resource "<PROVIDER>_<RESOURCE>" "<LOCAL_NAME>" {
  key = value
}
```

👉 Example (Azure Resource Group):

```hcl
resource "azurerm_resource_group" "choudhary" {
  name     = "chapri1"
  location = "West Europe"
}
```

---

### 🔹 Important Concepts

| Term                       | Meaning                         |
| -------------------------- | ------------------------------- |
| **resource**               | Defines infrastructure          |
| **azurerm_resource_group** | Resource type                   |
| **choudhary**              | Local name (internal reference) |
| **name**                   | Actual Azure resource name      |
| **location**               | Region                          |

---

## 📦 8. Arguments in Terraform

### 🔹 Types of Arguments

| Type                   | Description      |
| ---------------------- | ---------------- |
| **Required Arguments** | Must be provided |
| **Optional Arguments** | Not mandatory    |

👉 Example:

* Required:

  * `name`
  * `location`
* Optional:

  * `tags`

---

## 🔄 9. Terraform Workflow

### Step-by-Step Execution

#### 1️⃣ Initialize Terraform

```bash
terraform init
```

* Downloads providers
* Prepares environment

---

#### 2️⃣ Validate Code

```bash
terraform validate
```

* Checks syntax errors

---

#### 3️⃣ Plan Execution

```bash
terraform plan
```

* Shows what will be created

---

#### 4️⃣ Apply Changes

```bash
terraform apply
```

* Creates resources in Azure

---

## 📁 10. Important Rule

👉 **Terraform runs in the folder where `.tf` file exists**

* Always:

```bash
cd <folder>
terraform apply
```

👉 Terraform automatically:

* Looks for `.tf` files in that folder

---

## 🧠 11. Core Understanding

### 🔹 Terraform Philosophy

* Terraform = **Combination of Blocks**
* Blocks combine to form infrastructure

👉 Simple analogy:

> “Block se block mile → Terraform code bane”

---

## 🧩 12. Concept Summary

| Concept    | Meaning                    |
| ---------- | -------------------------- |
| RG         | Logical container in Azure |
| CLI        | Imperative automation      |
| Terraform  | Declarative automation     |
| .tf file   | Infrastructure definition  |
| Block `{}` | Building unit              |
| Plan       | Preview                    |
| Apply      | Execution                  |

---

## 🎯 13. Quick Revision (Exam/Interview)

* Terraform is **declarative IaC tool**
* `.tf` file contains **resource blocks**
* Uses **providers (like azurerm)**
* Commands flow:

  ```
  init → validate → plan → apply
  ```
* Works on **desired state model**
