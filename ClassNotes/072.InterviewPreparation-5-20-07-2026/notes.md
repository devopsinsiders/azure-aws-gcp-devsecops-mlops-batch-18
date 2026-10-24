# 🏛️ Microsoft Cloud Adoption Framework (CAF) & Enterprise Design

> **Session Context:** Designing end-to-end Enterprise Cloud Architectures using the Microsoft Cloud Adoption Framework (CAF) across governance, security, and operations.
> **Reference File:** `diagram.pdf`

---

## 1. What is the Cloud Adoption Framework (CAF)?

The **Microsoft Cloud Adoption Framework (CAF)** provides proven guidance, best practices, and tools to help organizations create and implement cloud business and technology strategies.

```
                       The 6 Stages of CAF
                       -------------------
Strategy  --->  Plan  --->  Ready (Landing Zone)  --->  Adopt (Migrate/Innovate)
                             |
                   +---------+---------+
                   |                   |
                Govern               Manage
```

1. **Strategy:** Define business justification, ROI metrics, and executive sponsorship.
2. **Plan:** Align personnel, cloud readiness skills, and workload prioritization.
3. **Ready:** Architect and deploy the foundational **Azure Landing Zone**.
4. **Adopt:** Migrate existing workloads or build cloud-native applications.
5. **Govern:** Enforce compliance, regulatory standards, and cost control.
6. **Manage:** Maintain operational reliability, monitoring, and business continuity.

---

## 2. Core Pillars of an Enterprise Architecture

When asked in an architectural interview to design a cloud landing zone from scratch, structure your answer across these 10 pillars:
1. **Management Group & Subscription Hierarchy:** Segregate platform and workload subscriptions.
2. **Governance & Compliance:** Azure Policy initiatives, tag enforcement, resource limits.
3. **Identity & Access Management (IAM):** Microsoft Entra ID, PIM, Conditional Access, custom RBAC.
4. **Networking:** Hub-and-Spoke topology, Azure Firewall, Bastion, Private Endpoints.
5. **Compute & Workloads:** Multi-zone VMs, VMSS, AKS with auto-scaling.
6. **Security:** Zero-Trust architecture, Microsoft Defender for Cloud, Microsoft Sentinel SIEM.
7. **Storage & Data:** Encryption-at-rest with Customer-Managed Keys (CMK), private access only.
8. **Backup & Disaster Recovery (BCDR):** Recovery Services Vaults, Azure Site Recovery, defined RTO/RPO.
9. **Observability & Monitoring:** Centralized Log Analytics Workspace, DCR, KQL alerts.
10. **Cost Optimization:** Budgets, Cost Analysis alerts, Reserved Instances, Savings Plans.
