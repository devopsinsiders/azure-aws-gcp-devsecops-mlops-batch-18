# 🎙️ Interview Preparation II: Enterprise Project Architecture & Storytelling

> **Session Context:** Deep dive into the Axion Systems Petroleum Refinery project architecture, 3-tier monolithic landing zone design, multi-environment setups, and resume formatting.
> **Reference File:** `diagram.pdf`

---

## 1. The Enterprise Project: Axion Systems Petroleum IoT Dashboard

```
+---------------------------------------------------------------------------------+
|                       Petroleum Refineries (Global Locations)                   |
|  [ Motor 1 ]  [ Motor 2 ]  [ Motor 3 ]  [ Motor 4 ]  [ Motor 5 ]  [ Motor 6 ]   |
|  (IoT Sensors measure RPM, Temperature, Pressure, and Vibration Metrics)        |
+----------------------------------------+----------------------------------------+
                                         | Ingests telemetry data
                                         v
                              +--------------------+
                              |  Azure Event Hub   |
                              +----------+---------+
                                         |
                                         v
+---------------------------------------------------------------------------------+
|                     3-Tier Monitoring & Alerting Application                    |
|                                                                                 |
|  +--------------------+    +--------------------+    +-----------------------+  |
|  | Frontend Tier      |    | Backend Tier       |    | Database Tier         |  |
|  | React.js           | -> | Python API Service | -> | PostgreSQL / Azure SQL|  |
|  | (7-8 Developers)   |    | (10-12 Developers) |    | (Managed DB Team)     |  |
|  +--------------------+    +--------------------+    +-----------------------+  |
+---------------------------------------------------------------------------------+
```

---

## 2. The Production Landing Zone Architecture

```
                             End Users / Internet
                                      |
                                      v
+---------------------------------------------------------------------------------+
| Resource Group: rg-axion-prod                                                   |
| Virtual Network (10.0.0.0/16)                                                   |
|                                                                                 |
|  +---------------------------------------------------------------------------+  |
|  | ApplicationGWSubnet: Azure Application Gateway (WAF + SSL Offload)        |  |
|  +-------------------------------------+-------------------------------------+  |
|                                        |                                        |
|  +-------------------------------------v-------------------------------------+  |
|  | Frontend Subnet: 2x Frontend VMs (React Dashboard)                        |  |
|  +-------------------------------------+-------------------------------------+  |
|                                        |                                        |
|  +-------------------------------------v-------------------------------------+  |
|  | Internal Load Balancer (Distributes traffic across backend services)      |  |
|  +-------------------------------------+-------------------------------------+  |
|                                        |                                        |
|  +-------------------------------------v-------------------------------------+  |
|  | Backend Subnet: 2x Backend VMs (Python APIs)                              |  |
|  +-------------------------------------+-------------------------------------+  |
|                                        |                                        |
|  +-------------------------------------v-------------------------------------+  |
|  | Database Subnet: Private Endpoint to Azure SQL / PostgreSQL PaaS          |  |
|  +---------------------------------------------------------------------------+  |
|                                                                                 |
|  Shared Security Subnets:                                                       |
|  - AzureBastionSubnet: Azure Bastion Host (Zero Public IPs for SSH)             |
|  - KeyVaultSubnet: Azure Key Vault (Holds DB connection strings & certificates) |
+---------------------------------------------------------------------------------+
```

---

## 3. Resume Perfection Rules
* **Length:** Exactly 2 pages maximum.
* **Layout:** Clean, modern typography, no spelling or grammar mistakes.
* **Differentiation:** Avoid boilerplate templates; personalize project metrics and architectural responsibilities.
