# 🏛️ Azure Landing Zone Architecture & Doubt Clearing Session

> **Session Context:** Doubt-clearing session focusing on enterprise Azure Landing Zone definitions, archetypes, Management Group hierarchies, and connectivity topology.
> **Reference File:** `diagarm.pdf`

---

## 1. What is an Azure Landing Zone?

An **Azure Landing Zone** is the foundational, well-architected cloud environment that hosts enterprise application workloads. It accounts for scale, security governance, networking, identity, and disaster recovery based on the **Microsoft Cloud Adoption Framework (CAF)**.

### Why do we build Landing Zones?
* To provide a structured, secure, repeatable environment to run business applications.
* Deployed across On-Premises, Hybrid, and Multi-Cloud environments.

---

## 2. Five Archetypes of Landing Zones

1. **Monolithic Landing Zone:** Designed for traditional 3-tier VM workloads (Web, App, Database).
2. **Microservices Landing Zone:** Containerized workloads running on AKS (Azure Kubernetes Service) or Azure Container Apps.
3. **Machine Learning Landing Zone:** Optimized for compute-heavy ML pipelines, GPU clusters, and Azure Machine Learning workspaces.
4. **DataOps Landing Zone:** Scaled for big data analytics, Azure Synapse, Databricks, and Data Lake Storage.
5. **Agentic AI Landing Zone:** Specialized infrastructure for autonomous AI agents, orchestrators, LLM endpoints, and vector databases.

---

## 3. Enterprise Management Group & Subscription Hierarchy

```
                    +---------------------------+
                    |     Tenant Root Group     |
                    +-------------+-------------+
                                  |
            +---------------------+---------------------+
            |                                           |
+-----------v-----------+                   +-----------v-----------+
|      Platform MG      |                   |    Landing Zone MG    |
+-----------+-----------+                   +-----------+-----------+
            |                                           |
   +--------+--------+                         +--------+--------+
   |        |        |                         |                 |
+--v--+  +--v--+  +--v--+                   +--v---+          +--v---+
| Id  |  | Mgmt|  | Conn|                   |Non-P |          | Prod |
+-----+  +-----+  +-----+                   +--+---+          +--+---+
                                               |                 |
                                        +------+------+    +-----+-----+
                                        |      |      |    |           |
                                      [dev]  [tst]  [qa] [prod1]    [prod2]
```

### Hierarchy Breakdown:
* **Platform Management Group:** Houses shared core infrastructure subscriptions.
  * **Identity Subscription:** Entra ID, Domain Controllers, PIM, Key Vaults.
  * **Management Subscription:** Azure Monitor, Log Analytics Workspaces, Automation accounts.
  * **Connectivity Subscription (Hub VNet):** Azure Firewall, Azure Bastion, VPN / ExpressRoute Gateways.
* **Landing Zone Management Group:** Houses application workloads separated into:
  * **NonProd Subscriptions:** Dev Spoke VNet, Test Spoke VNet, QA Spoke VNet.
  * **Prod Subscriptions:** Prod VNet 1, Prod VNet 2.

---

## 4. Hub-and-Spoke Connectivity & On-Premises Integration

* **Hub VNet:** Central traffic router. Contains Azure Firewall, Azure Bastion, and VPN Gateway.
* **Spoke VNets:** Peer directly with the Hub VNet using VNet Peering.
* **On-Premises Network:** Connects to the Hub VNet via Site-to-Site (S2S) VPN Gateway or ExpressRoute.
* **Security Flow:** Workloads in Spokes communicate through the central firewall in the Hub rather than connecting directly to the internet.
