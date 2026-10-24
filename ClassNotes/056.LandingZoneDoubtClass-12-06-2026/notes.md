# 🏛️ Enterprise Landing Zone Architecture & Design Principles

> **Session Context:** Deep doubt-clearing session on end-to-end Enterprise Landing Zone design, CAF pillars, monolithic vs microservice infrastructure, and automation.
> **Reference File:** `diagram.pdf`

---

## 1. Why Azure & Terraform?

```
+------------------------------------+      +-----------------------------------+
|            Azure Cloud             |      |             Terraform             |
|  (The Enterprise Supermarket)     |  +   |  (The Declarative IaC Engine)     |
|  Provides infrastructure blocks:   |      |  Automates provisioning reliably, |
|  Compute, Network, IAM, Storage    |      |  repeatably, and without drift.   |
+------------------------------------+      +-----------------------------------+
                                  |
                                  v
                +-----------------------------------+
                |     Enterprise Landing Zone       |
                |   (Hosts Business Applications)   |
                +-----------------------------------+
```

---

## 2. Helipad vs Runway Analogy

| Workload Type | Cloud Infrastructure Requirement | Analogy |
| :--- | :--- | :--- |
| **Monolithic Application** | Virtual Machine-based Landing Zone (VMs, Managed Disks, VNets, Subnets) | **Helipad** (Designed for Helicopters) |
| **Microservices Application** | Container-based Landing Zone (AKS, Container Apps, Ingress, Service Mesh) | **Runway / Landing Strip** (Designed for Aeroplanes) |

> ✈️ Just as you cannot land a Boeing 777 on a helipad, you cannot force microservice architectures onto a simple monolithic landing zone without proper ingress, container orchestration, and dynamic scaling!

---

## 3. The 9 Enterprise Landing Zone Pillars

1. **Hierarchy:** Management Groups (Tenant Root, Platform, Landing Zones), Subscriptions, Resource Groups.
2. **IAM & Security:** Microsoft Entra ID (Azure AD), RBAC role assignments, PIM (Privileged Identity Management), Conditional Access.
3. **Governance & Compliance:** Azure Policies (built-in and custom), Policy Initiatives, Management Group assignments, Cost budgets.
4. **Networking:** Hub-and-Spoke topology, VNet Peering, Global Peering, Azure Firewall, ExpressRoute, VPN Gateways (Site-to-Site & Point-to-Site).
5. **Compute & Workloads:** Virtual Machines, VM Scale Sets (VMSS), Azure App Services, Azure Functions, AKS.
6. **Advanced Traffic & Load Balancing:** Azure Load Balancer (L4), Application Gateway (L7 + WAF), Azure Front Door, Traffic Manager, Azure Bastion.
7. **Storage & Databases:** Azure Storage Accounts, Azure SQL Managed Instances, Cosmos DB.
8. **Backup & Disaster Recovery (BCDR):** Recovery Services Vaults, Backup Vaults, Azure Site Recovery (ASR), defining RPO & RTO.
9. **Monitoring & Security Operations:** Azure Monitor, Log Analytics Workspaces, Microsoft Defender for Cloud, Microsoft Sentinel (SIEM/SOAR).

---

## 4. Automation Strategy: Custom Data vs Provisioners

When provisioning VMs with Terraform:
* ❌ **Terraform Provisioners (`remote-exec`, `local-exec`):** Brittle, requires direct network connectivity and SSH credentials in code, breaks idempotency ("Jhandu approach").
* ✅ **`custom_data` / Cloud-init:** Native OS bootstrapping mechanism passed during VM creation. Robust, decoupled, and runs independently during initial boot ("Dhasu approach").
