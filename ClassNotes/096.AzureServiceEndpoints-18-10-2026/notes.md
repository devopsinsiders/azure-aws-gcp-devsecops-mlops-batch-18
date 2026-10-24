# 🌐 Azure Service Endpoints vs. Private Endpoints

> **Session Context:** Restricting PaaS data access, how Service Endpoints work, DNS routing changes, and why Private Endpoints are the enterprise standard.
> **Reference File:** `diagram.pdf`

---

## 1. The Problem with Default Public Cloud Endpoints

By default, Azure PaaS services (Storage Accounts, SQL Databases) have public DNS names and public IP addresses accessible from the internet.

```
PaaS Service URL: diarchitectwa.blob.core.windows.net
Resolved to Public IP: 20.209.173.195 (Accessible from anywhere!)
```

---

## 2. What is an Azure Service Endpoint?

A **Service Endpoint** extends your Virtual Network's private address space to Azure PaaS services over the Microsoft backbone network.

```
Virtual Machine in Subnet
(10.0.1.4)
    |
    | Enables "Microsoft.Storage" Service Endpoint on Subnet
    v
+-----------------------------+
| Azure Backbone Routing      |
+--------------+--------------+
               |
               v
Storage Account Firewall:
"Allow access from selected Virtual Networks: frontend-subnet"
```

### Characteristics of Service Endpoints:
* The PaaS resource **still maintains its Public IP address**.
* Traffic bypasses the public internet and routes directly across Microsoft's internal backbone.
* Access is restricted using the PaaS resource's firewall rules.

---

## 3. Why Enterprise Architecture Prefers Private Endpoints

* **Service Endpoints:** The PaaS service still has a public IP; cross-VNet or on-premises VPN traffic cannot use service endpoints without complex NAT.
* **Private Endpoints (Azure Private Link):** Assigns a **private IP directly from your VNet subnet** to the PaaS service via a Network Interface (NIC), completely disabling public internet exposure!
