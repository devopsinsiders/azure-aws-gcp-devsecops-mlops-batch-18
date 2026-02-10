# Azure Entra ID & RBAC – Detailed Notes

> These notes are prepared based on the uploaded PDF/diagram used in class (Batch 18). Language and examples are intentionally kept simple and Hinglish-style for easy understanding.

---

## 1. Azure Account (Root Level)

* **Azure Account** is the starting point (example name used: **KGF**).
* Ye account billing se linked hota hai.
* **Subscription charges** example: ~₹18,000
* Ek Azure account ke andar multiple **Subscriptions** ho sakti hain.

👉 *Billing + Ownership yahin se start hota hai.*

---

## 2. Azure Entra ID (Previously Azure Active Directory)

* Entra ID is **Identity & Access Management (IAM)** service of Azure.
* Free license me bhi basic features available hote hain.

### Entra ID kya karta hai?

* Users ko manage karta hai
* Authentication & Authorization handle karta hai
* Roles assign karta hai

---

## 3. Authentication vs Authorization

### Authentication – *"Andar ghusna"*

* Matlab: **Tum kaun ho?**
* Username + Password
* OTP / Token / MFA
* Example:

  * `portal.azure.com`
  * Gate se entry

### Authorization – *"Andar kya kar sakte ho"*

* Matlab: **Tumhe kya-kya rights mile hain?**
* Ye roles se decide hota hai

---

## 4. Users in Entra ID (Example Characters)

### 1. Bhakua Engineer

* Login using:

  * Username
  * Password
  * OTP / Token
* Authentication successful hone ke baad hi portal access milega

### 2. Tinku

* Entra ID & Azure roles assign kiye ja sakte hain
* Tinku naye users ko onboard kar sakta hai (agar rights mile ho)

### 3. Babli

* Example of resource-level access
* Specific resource group access
* Example command:

  * `ssh devopsadmin@135.235.183.160`

---

## 5. Roles in Azure (Very Important 🔥)

### A. Entra ID Roles (Tenant Level)

1. **Global Administrator (Papa 👑)**

   * Sabse powerful role
   * Entra ID ka full control
   * Users, roles, policies – sab kuch

2. **User Administrator**

   * Users create/delete/update
   * Password reset

3. **Privileged Role Administrator**

   * High-privilege roles manage karta hai

---

### B. Azure Roles (Subscription / Resource Level)

1. **Owner**

   * Full access
   * Roles assign kar sakta hai

2. **Contributor**

   * Resources create/update/delete
   * Par roles assign nahi kar sakta

3. **Reader**

   * Sirf read-only access

---

## 6. Tenant Root Group

* Azure hierarchy ka top-most level
* Sabhi management groups yahin se start hote hain
* Global governance apply hoti hai

---

## 7. Management Groups & Departments

Example hierarchy:

* **Tenant Root Group**

  * DevOps Insiders

    * Sales Department
    * HR Department
    * Accounts Department
    * Tech Department

### Benefits:

* Policies apply karna easy
* Access control simple
* Cost tracking department-wise

---

## 8. Applications & Projects

Examples:

* Invoice Application
* Leads Application
* Sample Project

### Revenue Example:

* ₹5,00,000 per month

Managers:

* HR Manager
* Sales Manager

---

## 9. Hierarchy ke Fayde (Why Hierarchy Matters?)

1. **Security** 🔐

   * Least privilege access

2. **Cost Management** 💰

   * Department-wise billing

3. **Isolation** 🧱

   * Ek department ka issue dusre ko affect nahi karega

4. **Scalability** 🚀

   * Naye users / teams easily add ho sakte hain

---

## 10. Role Based Access Control (RBAC)

### RBAC ka funda:

> *Right person ko, right access, right scope par*

### Access dene ke liye 2 cheezein zaroori hain:

1. **Role** (Owner / Contributor / Reader)
2. **Scope**

   * Management Group
   * Subscription
   * Resource Group
   * Resource

Example:

* Babli ko sirf `babli-rg` par Contributor access

---

## 11. Important Rule (Interview Ready 🔥)

> Kisi bhi user ko access dene ke liye **User Administrator** ya **Subscription Owner** hona zaroori hai.

---

## 12. Real-World Mapping

* **Global Admin** = Company ka Owner
* **Subscription Owner** = IT Head
* **Contributor** = DevOps / Engineers
* **Reader** = Auditor / Management

---

## 13. One-Line Summary

* **Authentication** = Entry
* **Authorization** = Power
* **Entra ID** = Identity
* **RBAC** = Control
* **Hierarchy** = Security + Cost + Scale

---

🙏 *कर्म ही पूजा है*
