# 🎙️ Master "Tell Me About Yourself" (TMAY) Pitch & Project Architecture

> **Folder Context:** `ClassNotes/100.TellmeAboutYourself-28-10-2026/`  
> **Source Reference:** `diagram.pdf` (Industrial IoT Predictive Monitoring Platform on Azure)  
> **Target Audience:** DevOps / DevSecOps Engineer (3–5+ years experience)

---

## 🧭 Why Most "Tell Me About Yourself" Answers Fail

Most candidates treat this question like an oral reading of their resume:
* *"I graduated in 2019, then worked on Java, then moved to AWS, then I learned Docker..."* 😴

**Interviewers tune out within 30 seconds.**

### The Real Goal of This Answer
1. **Control the Interview:** You are giving the interviewer a clear roadmap of what you want them to ask you about next.
2. **Anchor on One Real Project:** Don't list 10 shallow tools. Anchor yourself in an end-to-end, production-grade business case.
3. **Sound Like a Working Engineer, Not a Student:** Speak about real team constraints (Reader-only access, manual approval gates, cost checks, cross-time-zone collaboration, and production troubleshooting).

---

## ⏱️ The 5-Phase Pitch Framework (2.5 to 3 Minutes)

```
[ Phase 1: 30 Sec ] ──> Identity, core tech stack & day-to-day focus
        │
[ Phase 2: 45 Sec ] ──> Business Problem (Australian Petroleum Refineries & IoT)
        │
[ Phase 3: 20 Sec ] ──> Team Structure & Your Exact Ownership
        │
[ Phase 4: 45 Sec ] ──> Azure Landing Zone Architecture (Traffic flow & Security)
        │
[ Phase 5: 40 Sec ] ──> DevSecOps Automation (Terraform + Infracost + SonarQube + Liquibase)
        │
[ The Pass-back   ] ──> Hand control back with confidence
```

---

## 🗣️ Word-for-Word Natural Spoken Script

> 💡 **Delivery Advice:** Speak at a calm, conversational pace. Don't rush like you memorized a script. Pause after key sentences to let the interviewer absorb the architectural choices.

### [Phase 1: The Hook & Day-to-Day Routine (~30 seconds)]
*"Thanks for having me today.*

*To give you a quick summary—I’ve been working as a DevSecOps Consultant for the past 3 years. My core day-to-day responsibilities revolve around writing modular Terraform code, building end-to-end Azure YAML CI/CD pipelines, collaborating on cloud architecture diagrams, and actively troubleshooting production issues when deployments or infrastructure drift happen.*

*If you’re comfortable, I’d love to walk you through the primary project I’m currently driving."*

---

### [Phase 2: The Business Problem & Use Case (~45 seconds)]
*(Wait for a quick nod or simply continue smoothly...)*

*"Currently, I'm working with an enterprise customer based out of Australia in the oil and gas sector. They operate multiple petroleum refineries across Australia.*

*In these refineries, they have hundreds of heavy, continuous rotating machinery—specifically large industrial motors and pumps. If even one of these pumps overheats, fails, or seizes up unexpectedly, it causes immediate refinery downtime, which directly costs the client thousands of dollars an hour in lost production.*

*To solve this, our engagement is to build a real-time IoT condition-monitoring, dashboarding, and alerting platform.*

*The customer already has an in-house hardware engineering team that installed industrial IoT sensors on all critical motors across the refineries. Those edge devices continuously push telemetry data—like vibrations, pressure, and operational temperatures—straight into Azure Cloud via Azure Event Hub.*

*Our software team’s job begins right where data lands in Event Hub: we ingest those streaming metrics, surface real-time analytics on an industrial dashboard, and trigger automated threshold alerts. For instance, if an industrial pump crosses 100°C, the platform immediately alerts the field refinery operator so they can gracefully isolate or shut down the pump before catastrophic failure occurs."*

---

### [Phase 3: The Team Structure & My Ownership (~20 seconds)]
*"From a team standpoint, we operate in an Agile sprint model with about 14 people: 5 frontend engineers, 7 backend engineers, a dedicated database engineer, and myself owning the DevSecOps workstream.*

*My responsibility covers three core pillars:*
1. *Designing and provisioning the secure Azure Landing Zone using Terraform,*
2. *Establishing our Git branching strategy and repository standards,*
3. *Automating both our Infrastructure and Application CI/CD pipelines."*

---

### [Phase 4: Azure Landing Zone & Architecture (~45 seconds)]
*"Let me quickly walk you through the landing zone architecture we designed for this platform:*

* **Edge & Ingress:** The entry point to our environment is an **Azure Application Gateway** configured with SSL/TLS offloading and WAF (Web Application Firewall) enabled for Layer-7 protection against common web attacks.
* **Frontend Tier:** Traffic from the App Gateway routes into our private **Frontend Subnet**, where we run 2 Linux VMs hosting our UI application.
* **Backend Tier:** The frontend VMs talk to an **Internal Azure Load Balancer (ILB)** sitting in our private **Backend Subnet**, which evenly distributes API traffic across 2 backend application VMs.
* **Data Tier:** For persistence, we use **Azure Database for PostgreSQL Flexible Server**. Crucially, the database has zero public internet endpoints—it lives in a dedicated Database Subnet and connects to the backend solely via **Azure Private Endpoints**.
* **Access & Secrets:** For zero-trust administrative access, we have an **Azure Bastion** deployed in a dedicated `BastionSubnet`, so nobody connects over raw public IPs. All application secrets, database credentials, and SSL certificates are strictly stored in **Azure Key Vault**."*

---

### [Phase 5: DevSecOps Automation (IaC & Pipelines) (~40 seconds)]
*"On the automation side, we have strict governance: **nobody in the company—not even developers or leads—has Contributor access in the Azure Portal**. Everyone has Reader access for visibility. All changes must happen via Infrastructure as Code.*

* **Terraform Standards:** We follow a **Trunk-Based branching strategy** in our Terraform repo. The architecture is modular: we maintain a `modules/` folder with reusable child modules for each Azure resource, and an `environments/` directory where root configurations call child modules with environment-specific `.tfvars` (Dev, QA, Prod).
* **Terraform Pipeline Gates:** Our Azure YAML pipeline doesn't just run plan and apply. It runs:
  1. Static security scanning with **tfsec** and linting with **tflint**.
  2. `terraform validate` and `terraform plan`.
  3. Cost estimation using **Infracost** right on the PR stage so architects see month-over-month dollar impact before approving.
  4. A **Manual Approval Gate** before the automated `terraform apply` runs via customer-managed Service Connections.
* **Application CI/CD:** We maintain separate YAML pipelines for frontend, backend, and database. Both frontend and backend pipelines pass through a **SonarQube Quality Gate**, produce tested build artifacts, and deploy through **Dev -> Manual Approval -> QA -> Manual Approval -> Production**.
* **Database Migrations:** For our PostgreSQL database, we automated schema updates using **Liquibase** inside our deployment pipeline, so DB versioning moves hand-in-hand with backend code."*

---

### [The Pass-Back: Closing the Pitch (~10 seconds)]
*"So that's a high-level picture of my current role, the business problem we solved, and the DevSecOps practices we implemented. I'd be very happy to dive deeper into our Terraform structure, pipeline security gates, or any specific architectural choice you'd like to explore!"*

---

## 🏛️ Architecture & System Topology (Reference Diagram)

```
                             [ Industrial Motors & Pumps ]
                            (Refinery IoT Sensors on Edge)
                                          │
                                          ▼ Telemetry Stream
                                 [ Azure Event Hub ]
                                          │
══════════════════════════════════════════╪══════════════════════════════════════════
               Azure Virtual Network (Landing Zone VNet)
══════════════════════════════════════════╪══════════════════════════════════════════
                                          │
                                  ( Public Traffic )
                                          │
                                          ▼
                      +---------------------------------------+
                      |       Azure Application Gateway       |
                      |   [ SSL Offloading ] + [ Azure WAF ]  |
                      +---------------------------------------+
                                          │
                    ┌─────────────────────┴─────────────────────┐
                    │                                           │
                    ▼                                           ▼
          +───────────────────+                       +───────────────────+
          | Frontend VM (ui1) |                       | Frontend VM (ui2) |
          +───────────────────+                       +───────────────────+
             [ Subnet: 10.0.1.0/24 - Frontend Subnet (Private IP Only) ]
                                          │
                                          ▼
                      +---------------------------------------+
                      |     Internal Load Balancer (ILB)      |
                      +---------------------------------------+
                                          │
                    ┌─────────────────────┴─────────────────────┐
                    │                                           │
                    ▼                                           ▼
          +───────────────────+                       +───────────────────+
          |  Backend VM (api1)|                       |  Backend VM (api2)|
          +───────────────────+                       +───────────────────+
              [ Subnet: 10.0.2.0/24 - Backend Subnet (Private IP Only) ]
                                          │
                                          ▼ (Private Endpoint Connection)
                      +---------------------------------------+
                      |  Azure PostgreSQL Flexible Server     |
                      |   (Private DNS Zone Integration)      |
                      +---------------------------------------+
                          [ Subnet: 10.0.3.0/24 - DB Subnet ]

─────────────────────────────────────────────────────────────────────────────────
 Management & Security Subnets in Same VNet:
  • [ Azure Bastion Subnet (10.0.4.0/27) ] ──> Secure RDP/SSH to all Private VMs
  • [ Azure Key Vault (Private Endpoint) ] ──> Centralized Secrets, DB Strings & SSL
─────────────────────────────────────────────────────────────────────────────────
```

---

## 🛠️ Deep Dive: Terraform Repository Architecture

To speak with authority, you must explain your folder structure without hesitating:

```
terraform-azure-landingzone/
├── .github/ OR azure-pipelines/
│   └── terraform-pipeline.yml          # Multi-stage CI/CD pipeline
├── modules/                            # Reusable child modules (No hardcoding)
│   ├── vnet/                           # VNet, Subnets, NSGs
│   ├── app_gateway/                    # WAF, listeners, SSL certs
│   ├── compute_frontend/               # VM instances, NICs, cloud-init
│   ├── internal_lb/                    # ILB, backend pools, health probes
│   ├── compute_backend/                # Backend API VMs
│   ├── postgres_flexible/              # DB instance, firewall, private endpoint
│   ├── bastion/                        # Azure Bastion host
│   └── key_vault/                      # Key Vault, access policies / RBAC
└── environments/                       # Root module calling child modules
    ├── dev/
    │   ├── main.tf                     # module "vnet" { source = "../../modules/vnet" ... }
    │   ├── variables.tf
    │   ├── terraform.tfvars            # Dev specific sizing (e.g. Standard_B2s)
    │   └── backend.tf                  # Azure Blob Storage state backend
    ├── qa/
    │   ├── main.tf
    │   ├── terraform.tfvars            # QA sizing
    │   └── backend.tf
    └── prod/
        ├── main.tf
        ├── terraform.tfvars            # Prod sizing (e.g. Standard_D4s_v5, HA DB)
        └── backend.tf
```

### Key Engineering Practices to Highlight
* **Trunk-Based Development:** Short-lived feature branches cut from `main`. Features merged via PR requiring 2 peer reviews and green CI checks.
* **Remote State with Locking:** State files stored in Azure Blob Storage with automated lease locking (`azurerm` backend).
* **Zero-Touch Azure Portal:** No engineer holds `Contributor` rights. Even production changes go through Azure DevOps Service Connections using Managed Identities / Service Principals with least privilege.

---

## 🚀 DevSecOps Pipeline Stages

### 1. Terraform Infrastructure Pipeline (`terraform-pipeline.yml`)

| Stage | Tools Used | What It Actually Does in Our Project |
|---|---|---|
| **1. Static Code Analysis** | `tflint`, `tfsec` (Trivy) | Checks for missing tags, unencrypted disks, open 0.0.0.0/0 NSG rules, and syntax errors before cloud execution. |
| **2. Validation & Plan** | `terraform validate`, `terraform plan` | Generates execution plan artifact against the target environment. |
| **3. FinOps / Cost Gate** | `infracost` | Automatically posts a comment on the Pull Request showing estimated monthly cloud cost delta (e.g., *"+$142/month for 2 new VMs"*). |
| **4. Manual Approval Gate** | Azure Environment Approvals | Architecture Lead / Tech Lead reviews the output plan and cost breakdown. |
| **5. Provisioning / Apply** | `terraform apply -input=false tfplan` | Strictly runs the pre-approved plan artifact. |

### 2. Application Pipelines (Frontend & Backend)

```
[ Git Push / PR ] 
       │
       ▼
[ Stage 1: SonarQube Scan ] ──> Security bugs, Code Smells, Coverage > 80%
       │
       ▼ (Pass Quality Gate)
[ Stage 2: Application Build ] ──> Compiles, packages, runs unit tests
       │
       ▼
[ Stage 3: Publish Artifacts ] ──> Uploads tar.gz/zip to Azure Pipeline Artifacts
       │
       ▼
[ Stage 4: Deploy to DEV ] ──> Automated deployment to DEV VMs
       │
       ▼
[ Stage 5: Manual Approval Gate ] ──> QA Lead Signoff
       │
       ▼
[ Stage 6: Deploy to QA ] ──> Automated deployment to QA VMs (Automation testing)
       │
       ▼
[ Stage 7: Production Gate ] ──> Change Advisory Board (CAB) / Prod Manager Approval
       │
       ▼
[ Stage 8: Deploy to PROD ] ──> Zero-downtime rolling deployment
```

### 3. Database CI/CD Pipeline (`Liquibase`)
* **Problem:** Developers used to manually send `.sql` scripts to the DBA via chat, causing schema drift between QA and Prod.
* **Solution:** Added **Liquibase** into the database pipeline.
* Database changes are tracked in XML/SQL formatted `changelog.sql` files stored in Git.
* When the pipeline triggers, Liquibase checks `DATABASECHANGELOG` tables on Azure Postgres and only executes unapplied changesets automatically.

---

## 🎯 Realistic Follow-Up Questions & How to Answer

### Q1: *"Why did you use Application Gateway instead of Azure Front Door or Azure Load Balancer?"*
> **Answer:**  
> *"That was a deliberate design choice based on our client's scope. Azure Front Door is a global service optimized for multi-region routing. In our case, all the refineries are within Australia, and our workloads reside purely in the Australia East region.  
> A standard Azure Load Balancer operates at Layer 4 (TCP/UDP), which lacks SSL offloading, URL path-based routing, and Layer 7 inspection.  
> Azure Application Gateway gave us built-in Web Application Firewall (WAF) to protect against OWASP Top 10 vulnerabilities, native SSL termination using certificates stored in Azure Key Vault, and cookie-based session affinity for our dashboard UI."*

---

### Q2: *"Why are you running applications on Virtual Machines rather than Azure Kubernetes Service (AKS) or Azure App Service?"*
> **Answer:**  
> *"That's a very common question. When we took on this contract, the client had an existing monolithic/3-tier architecture with stateful logging agents tightly coupled to local VM OS services.  
> Our primary phase was to establish a rock-solid, secure Azure Landing Zone and automate IaC and CI/CD without introducing the operational complexity of Kubernetes overnight.  
> Right now, in Phase 2, we are already containerizing the backend microservices using Docker and drafting the migration plan toward Azure Container Apps / AKS. But for high-reliability Phase 1, hardened VMs with modular Terraform gave the client immediate stability."*

---

### Q3: *"How do you handle secrets during the pipeline execution?"*
> **Answer:**  
> *"We follow strict zero-hardcoding rules:
> 1. Secrets are stored in Azure Key Vault.
> 2. In our Azure DevOps pipelines, we link Azure Key Vault directly to our Pipeline Variable Groups or use the `AzureKeyVault@2` task to download secrets at runtime.
> 3. For Terraform, we retrieve secret references dynamically or pass them securely via pipeline variables marked as 'Secret', preventing them from ever printing in console logs."*

---

### Q4: *"What is a real production issue you troubleshot recently?"*
> **Answer:**  
> *"Recently, after a major backend release, our monitoring alerts triggered because our backend VMs were failing their health probes from the Internal Load Balancer, causing intermittent 502 errors on the App Gateway.  
> We hopped on the emergency bridge, used Azure Bastion to SSH securely into the backend VM, and inspected `systemctl` status and application logs.  
> We discovered that a recent database connection pool setting in the backend API had saturated the max connections on Azure Postgres Flexible Server due to an unindexed telemetry query run by the dashboard.  
> As an immediate fix, we recycled the backend process and increased the Postgres connection limit. The permanent fix was a PR updating the query indexing via Liquibase and configuring connection pooling via PgBouncer."*

---

## 💡 Quick Checklist for Interview Day

- [ ] **Check Time Zone Reference:** If interviewing with Australian clients, note the AEST/AEDT vs IST difference (~4.5 to 5.5 hours ahead).
- [ ] **Speak in Sentences, Not Bullet Points:** Connect thoughts with *"Because of this..."*, *"To solve this..."*, *"From a security standpoint..."*.
- [ ] **Don't Over-Explain Syntax:** Nobody cares about `variable "foo" { type = string }`. They care about **why** you used modules, **how** you handled state, and **what** security tools protected production.
- [ ] **Keep Calm on Architecture Questions:** If asked something you didn't configure personally, say: *"In our current architecture, that was managed by the network core team, but the way we integrated with it was..."*
