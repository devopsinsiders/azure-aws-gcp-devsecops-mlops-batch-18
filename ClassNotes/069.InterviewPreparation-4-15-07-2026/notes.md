# 🎙️ Interview Preparation IV: Axion Systems IoT Dashboard Story

> **Session Context:** Complete architectural walkthrough of the Axion Systems Petroleum Refinery IoT Monitoring Dashboard project.
> **Reference File:** `diagram.pdf`

---

## 1. The Enterprise Client Problem & IoT Pipeline

```
Refinery Floor (Sensors)           Azure Cloud Ingestion            Application Layer
+-------------------------+        +-------------------+        +-----------------------+
| Industrial Pumps/Motors |        |                   |        | 3-Tier Dashboard App  |
| - Motor 1 (RPM, Temp)   | -----> |  Azure Event Hub  | -----> | React Frontend        |
| - Motor 2 (Vibration)   |        |  (Telemetry Data) |        | Python Backend API    |
| - Motor 3 (Pressure)    |        |                   |        | PostgreSQL Database   |
+-------------------------+        +-------------------+        +-----------------------+
```

### The Business Narrative:
*"Our customer operates industrial petroleum refineries worldwide. Each facility has hundreds of critical motors and centrifugal pumps. The client's electrical engineering squad deployed Industrial IoT devices to capture telemetry metrics (RPM, temperature, oil pressure, and vibration). This high-velocity data streams directly into **Azure Event Hub**. Our team designed and deployed the 3-tier web application that monitors telemetry in real-time, generates trend graphs, and triggers predictive maintenance alerts."*

---

## 2. DevSecOps Consultant Responsibilities

When describing your personal contributions:
1. **Landing Zone Design:** Architected the secure Hub-and-Spoke network topology, segregating Web, App, and Data tiers into dedicated subnets.
2. **Infrastructure as Code:** Built reusable Terraform child modules for Virtual Networks, Application Gateway, Linux/Windows VMs, and Azure Key Vault.
3. **Shift-Left Security:** Integrated static code analyzers (`tfsec`, `checkov`), linting (`tflint`), and secret scanning (`trufflehog`) into PR pipelines.
4. **CI/CD Automation:** Authored multi-stage YAML pipelines in Azure DevOps with gated environment approvals for Dev, QA, and Production.
