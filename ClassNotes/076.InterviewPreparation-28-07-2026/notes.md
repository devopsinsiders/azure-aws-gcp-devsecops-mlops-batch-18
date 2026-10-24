# 📊 Enterprise Monitoring, Log Analytics & Observability

> **Session Context:** End-to-end monitoring architecture for Azure Landing Zones, Azure Native vs Open Source tools, Log Analytics, KQL, AMA, and DCR.
> **Reference File:** `diagram.pdf`

---

## 1. What is Monitoring in an Azure Landing Zone?

**Monitoring** is the continuous collection, analysis, correlation, and alerting of telemetry across the entire cloud landing zone to ensure resources remain **available, healthy, secure, performant, compliant, and cost-efficient**.

### Scope of End-to-End Enterprise Monitoring:
* **Infrastructure:** VMs, VMSS, AKS clusters, Azure SQL, Storage Accounts, App Services.
* **Networking:** VNet Flow Logs, Azure Firewall logs, ExpressRoute circuits, VPN tunnels, Application Gateway logs.
* **Identity & Access:** Entra ID sign-in logs, MFA failures, PIM elevation audits, RBAC changes.
* **Security & Threats:** Microsoft Defender for Cloud alerts, Sentinel incident detection.
* **Business Continuity:** Recovery Services Vault backup job statuses, ASR replication health.
* **FinOps / Cost:** Budget thresholds, anomaly detection alerts.

---

## 2. Azure Native Observability Architecture

```
Monitored Resources (VMs, Firewalls, Apps)
                     |
                     | Azure Monitor Agent (AMA) + Diagnostic Settings
                     | (Filtered by Data Collection Rules - DCR)
                     v
+-------------------------------------------------------------+
|               Log Analytics Workspace (Central)             |
|  - Stores structured logs in columnar tables                |
|  - Queried using KQL (Kusto Query Language)                 |
+------------------------------+------------------------------+
                               |
        +----------------------+----------------------+
        |                                             |
+-------v-------+                             +-------v-------+
|  Alert Rules  |                             | Visualizations|
| (CPU > 70%,   |                             | - Dashboards  |
| Login fails)  |                             | - Grafana     |
+-------+-------+                             | - Power BI    |
        |                                     +---------------+
        v
+---------------+
| Action Groups |
| (Email, Slack,|
|  Teams, Pager)|
+---------------+
```

---

## 3. Azure Monitor Agent (AMA) & Data Collection Rules (DCR)

* **Legacy MMA (Log Analytics Agent):** Deprecated. Pushed all telemetry indiscriminately, incurring massive data ingestion costs.
* **Modern AMA (Azure Monitor Agent):**
  * Uses **Data Collection Rules (DCR)** to filter what to collect directly at the source.
  * Collects specific Windows Event IDs, Linux Syslog facilities, and custom performance counters before sending data to Log Analytics.

---

## 4. Observability Best Practices

1. Deploy a **centralized Log Analytics Workspace** in the dedicated Management subscription.
2. Configure **DCR rules** to ingest only actionable, critical security and performance logs.
3. Enable **Diagnostic Settings** on all PaaS services (Key Vault, App Gateway, Storage).
4. Configure **Action Groups** integrated with Microsoft Teams, Slack, or PagerDuty.
5. Create operational dashboards in Azure Managed Grafana or Power BI.
