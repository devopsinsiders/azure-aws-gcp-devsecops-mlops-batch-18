# Batch 18 – DevOps / Cloud Learning Notes

## 1. Daily Discipline & Routine

Ek successful engineer banne ke liye **daily discipline** bahut important hai.

### Daily Rules

* Har din **morning me diary likhni hai**
* Morning me **day plan banana hai**
* Proper **planned way me din chalana hai**
* Pehle **khud assignment karna hai**
* Uske baad **group me baith kar dusron ko samjhana hai**

### Time Management Example

| Activity         | Time      |
| ---------------- | --------- |
| Manager / Office | 12 Hours  |
| Sleep            | 6 Hours   |
| Family / TV      | 2 Hours   |
| Travelling       | 2 Hours   |
| Reels / Timepass | 30–40 min |
| Learning         | 1 Hour    |

👉 Agar **sleep 7 ghante se 6 ghante** kar do to **1 extra hour learning** ke liye mil jata hai.

### Study Strategy

* Week me **5 din padhna hai**
* **Monday** → Assignment khud solve karna
* **Tuesday – Friday** → Group learning

### Group Learning Rules

* Screen share karke **topic padhana**
* Week me **2–3 baar teaching**
* IT me **screen sharing se hi kaam hota hai**

---

# 2. Career Reality in IT

* IT me **sirf 20% technology**
* **80% role communication aur collaboration**

Bahut se engineers:

* Coding expert nahi hote
* Documentation aur tools se kaam karte hain

Important skills:

* Google search
* Documentation reading
* Problem solving

---

# 3. Learning Mindset

Important points:

* Kisi se **jalna nahi**
* Sabko **job milegi**
* Technology ko **karke samajhna hai**

Example:

1100 students me se
316 students job ke liye bache
784 already placed

---

# 4. Basic Architecture Concept

### 3 Tier Architecture

Typical application architecture:

1️⃣ **Frontend Layer**
User interface

2️⃣ **Application Layer**
Business logic

3️⃣ **Database Layer**
Data storage

---

# 5. Practical Learning Example (StreamFlix)

Ek demo application **StreamFlix** ko different environments me run kiya gaya.

### 1️⃣ Local Windows

* IIS install
* StreamFlix deploy
* **1 Tier Application**

### 2️⃣ KillerKoda Linux

* Linux machine
* **NGINX install**
* StreamFlix run

### 3️⃣ Cloud VM

* Linux VM
* NGINX
* StreamFlix run

### 4️⃣ Azure VM

* VM create
* NGINX install
* StreamFlix run

---

# 6. Azure Account Setup

Azure environment me hierarchy hoti hai.

### Step 1

Lead ne **Azure account banaya**

Azure free credits mile
Example: **₹18000 credits**

### Step 2 – Entra ID

Lead ko mila:

* **Global Admin**

### Step 3 – Subscription

Lead ko mila:

* **Owner Role**

### Step 4 – Group Creation

Entra ID me group create kiya:

```
Siksha Sathi Group
```

### Step 5 – User Management

* Users ko **bulk import**
* Group ko **Contributor role**
* Sabko **ID & Password share**

Users login karke:

```
Azure Portal
```

access karte hain.

---

# 7. Azure Resource Creation

Azure portal me:

* Resource Group create
* Storage Account create

Methods:

1️⃣ Portal
2️⃣ CLI
3️⃣ Terraform

---

# 8. Infrastructure as Code (Terraform)

Terraform ek **Declarative Infrastructure Tool** hai.

### Imperative vs Declarative

**Imperative**

Direct command run

Example:

```
az vm create
kubectl create
```

---

**Declarative**

Desired state define karte hain.

Example:

```
Terraform
```

---

# 9. Terraform Files

Terraform me code **.tf files** me likha jata hai.

Example:

```
main.tf
variables.tf
outputs.tf
```

YAML files bhi tools me use hoti hain:

```
.yaml
```

---

# 10. Terraform Language

Terraform code likhne ki language:

**HCL**

Full Form:

```
Hashicorp Configuration Language
```

---

# 11. Terraform Registry

Terraform resources ka documentation:

```
Terraform Registry
```

Example search:

```
azure resource group terraform
aws s3 terraform
azure storage account terraform
```

Agar code search karna aa gaya to:

**70% kaam ho gaya**

Baaki **30% commands**.

---

# 12. Terraform Provider

Provider ka matlab:

Terraform kis cloud ke resources manage karega.

Example:

```
azurerm
aws
gcp
```

Example:

```
provider "azurerm"
```

---

# 13. Terraform Arguments

Arguments = resource create karne ke liye inputs.

### Types

#### 1️⃣ Required Arguments

Jo dena **zaruri hai**

Example:

```
name
location
resource_group_name
```

---

#### 2️⃣ Optional Arguments

Optional settings.

Example:

```
tags
replication_type
```

---

# 14. Attributes

Attributes = Resource create hone ke baad milne wali values.

Example:

* ID
* endpoint
* URL

Example:

Azure resource create hone ke baad **unique ID** milti hai.

---

# 15. Versioning in IT

Software versioning kyu hoti hai?

Main reasons:

1️⃣ Security fixes
2️⃣ New features
3️⃣ Bug fixes

---

# 16. Most Important Skill

Ek DevOps engineer ko aana chahiye:

✔ Google search
✔ Documentation reading
✔ Copy–paste + understanding

Example:

```
<CLOUD> <RESOURCE> terraform
```

Example searches:

```
azure resource group terraform
aws s3 terraform
azure storage account terraform
```

---

# 17. Terraform Commands

Terraform commands help se samjhe ja sakte hain.

Example:

```
terraform --help
```

---

✅ **Key Message**

* Discipline > Talent
* Documentation > Memory
* Practice > Theory

