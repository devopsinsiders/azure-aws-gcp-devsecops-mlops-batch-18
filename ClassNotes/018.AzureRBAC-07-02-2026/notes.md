## Azure Architecture & Landing Zone – Detailed Notes

### 1. What is a Landing Zone?

* **Landing Zone** refers to the **initial Azure architecture design** created before onboarding users, workloads, or applications.
* It defines **security, identity, access control, hierarchy, governance, and billing structure**.
* Think of it as the **foundation of a building**—if this is weak, everything on top becomes risky.

---

### 2. New User Onboarding Concept (Example: Bhakua & Chatua)

* When a **new user (Chatua)** joins an organization, they are onboarded through **Microsoft Entra ID**.
* A user like **Bhakua Engineer** is created and assigned appropriate roles based on responsibilities.
* The key question:

  > *"Bhakua engineer ko kya role dena chahiye aur kyun?"*

This decision is always **use‑case driven**.

---

### 3. Understanding Roles

#### What is a Role?

* A **role** defines **what actions a user can perform**.
* Roles follow the principle of **least privilege**.

#### Types of Roles

##### A. Built‑in Roles

* Predefined by Microsoft
* Common examples:

  * **Global Administrator** (Entra ID)
  * **Owner** (Azure Resources)
  * **Contributor**
  * **Reader**

> 📘 **Document reading is mandatory** before assigning roles blindly.

---

### 4. Entra ID vs Azure Roles (Very Important)

| Entra ID Roles        | Azure Roles              |
| --------------------- | ------------------------ |
| Identity-level access | Resource-level access    |
| Manage users, groups  | Manage VMs, Storage, AKS |
| Example: Global Admin | Example: Owner           |

* **Global Admin** = Boss of Entra ID only
* It does **NOT automatically give access to Azure resources**

---

### 5. Global Administrator (Papa Role 👨‍👧)

* Has **full control over Entra ID**
* Can:

  * Create users
  * Assign roles
  * Manage tenants
* Should be **very limited** (1–2 users only)

---

### 6. Azure Account – What Happens When You Create One?

When a new Azure account is created:

1. **Entra ID Tenant** is created
2. A **default user** is created
3. A **Management Group** is created automatically

   * Name: **Tenant Root Group**

This is the **topmost gate** of Azure hierarchy.

---

### 7. Azure Hierarchy (Homework Topic – Must Know)

```
Management Group (Tenant Root Group)
   ↓
Subscription
   ↓
Resource Group
   ↓
Resources (VM, AKS, Storage, DB)
```

* Hierarchy helps in:

  * Governance
  * Access control
  * Cost management

---

### 8. Azure Subscription

* Subscription is where **billing happens**
* Example:

  * ₹18,000 free credit
* Used by employees like **Tinku (Full Time Employee)**

Roles at subscription level:

* **Owner** – Full control
* **Contributor** – Can create/modify resources
* **Reader** – Read-only access

---

### 9. Authentication vs Authorization

#### Authentication (Andar ghusna 🚪)

* Username
* Password
* OTP
* Token

Portal: **portal.azure.com**

#### Authorization (Kya kar sakte ho?)

* Controlled using **roles**

---

### 10. Users & Groups in Entra ID

#### Users

* Example: Bhakua Engineer
* Login using:

  * Username
  * Password
  * OTP

#### Groups

* Best practice: **Assign roles to groups, not individuals**
* Easier management

---

### 11. Important Entra ID Roles

1. **Global Administrator** – Full tenant control
2. **User Administrator** – Manage users & groups
3. **Privileged Role Administrator** – Assign admin roles

---

### 12. DevOps Insiders – What We Are Known For

* Strong **fundamentals**
* Real‑world **use cases**
* **Screen sharing + live explanation**
* Teaching with **patience & consistency**
* Using tools like **draw.io** to explain architecture

---

### 13. Homework & Preparation Checklist

📌 Read about **Microsoft Entra ID**
📌 Understand **Users vs Groups**
📌 Learn **Built‑in Roles**
📌 Azure Hierarchy (MG → Subscription → RG)
📌 Difference between **Entra ID Roles & Azure Roles**

> 💡 Rule: *"Use case samajh ke role assign karo"*

---

### 14. Key Takeaway

* Landing Zone is the **most critical design** in Azure
* Wrong role assignment = **security risk**
* Global Admin ≠ Azure Owner
* Identity first, resources later

🙏 *कर्म ही पूजा है*
