# ⚙️ Production VM Deployment using Terraform Best Practices

> **Session Context:** Implementing enterprise-grade VM provisioning via Terraform, JIRA story analysis, security hardening, and resource ID cross-referencing.
> **Reference File:** `diagram.pdf`

---

## 1. Production JIRA User Story Analysis

**Requirement:** Provision 2 Virtual Machines in Azure adhering to enterprise DevSecOps standards.

### Mandatory Best Practice Checklist:
* [x] No hardcoded credentials or passwords in code or `.tfvars`.
* [x] Remote backend stored in Azure Storage Account with Customer-Managed Keys (CMK).
* [x] Child and Parent module architecture.
* [x] Automated static security scanning before merge (tfsec, checkov).
* [x] Proper lifecycle meta-arguments (`create_before_destroy = true`, `ignore_changes`).
* [x] Dynamic blocks and variable validation rules.
* [x] Comprehensive `README.md` documentation for modules.

---

## 2. Infrastructure Diagram: `rg-chor` & `vnet-chor`

```
Resource Group: rg-chor
Virtual Network: vnet-chor (10.0.0.0/16)
+---------------------------------------------------------------------------------+
| Frontend Subnet (10.0.1.0/24)                                                   |
|                                                                                 |
| +-----------------------------------------------------------------------------+ |
| |                           Frontend Virtual Machine                          | |
| |                                                                             | |
| |  [ Network Interface Card (NIC) ] <---- Attached to: frontend-subnet        | |
| |                 ^                                                           | |
| |                 | Associated with                                           | |
| |  [ Public IP (pip-chor-frontend-vm) ]                                       | |
| +-----------------------------------------------------------------------------+ |
|                                                                                 |
| Backend Subnet (10.0.2.0/24)                                                    |
|  [ Backend Virtual Machine (Private IP only) ]                                  |
+---------------------------------------------------------------------------------+
```

---

## 3. Understanding Azure Resource IDs

In Terraform, resources cross-reference each other using fully qualified Azure Resource Manager (ARM) IDs:

```
Subnet Resource ID:
/subscriptions/<subscription_id>/resourceGroups/rg-chor/providers/Microsoft.Network/virtualNetworks/vnet-chor/subnets/frontend-subnet

Public IP Resource ID:
/subscriptions/<subscription_id>/resourceGroups/rg-chor/providers/Microsoft.Network/publicIPAddresses/pip-chor-frontend-vm
```

When defining an `azurerm_network_interface`, the `subnet_id` and `public_ip_address_id` arguments accept these precise string identifiers.
