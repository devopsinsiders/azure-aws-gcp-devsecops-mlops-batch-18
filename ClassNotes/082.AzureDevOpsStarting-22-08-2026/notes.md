# 🚀 Introduction to Azure DevOps: Architecture, Stages, Jobs & Tasks

> **Session Context:** Evolution from Git to Azure DevOps, pipeline structural hierarchy (Stages, Jobs, Steps, Tasks), and agent execution models.
> **Reference File:** `diagram.pdf`

---

## 1. From Manual Infrastructure to Automated Pipelines

```
Manual Operations (Local Terminal)                Azure DevOps CI/CD Pipeline
+------------------------------------+            +------------------------------------+
| 1. git clone <repo>                |            | Stage: Preprod Deployment          |
| 2. cd environments/preprod         |            |   Job: Terraform Plan & Apply      |
| 3. az login                        |   ====>    |     Task 1: Install Terraform      |
| 4. terraform init                  |            |     Task 2: Azure CLI Login        |
| 5. terraform plan                  |            |     Task 3: Terraform Init & Plan  |
| 6. terraform apply --auto-approve  |            |     Task 4: Terraform Apply        |
+------------------------------------+            +------------------------------------+
```

---

## 2. Azure DevOps Pipeline Structural Hierarchy

```
Pipeline (Top Level)
  └── Stage 1: Build / Scan
  │     └── Job 1: Static Code Analysis (Agent 1)
  │           ├── Step 1: Checkout Code (Task)
  │           ├── Step 2: Run tfsec (Task)
  │           └── Step 3: Run tflint (Task)
  └── Stage 2: Deploy to Preprod (dependsOn: Stage 1)
        └── Job 1: Terraform Deployment (Agent 2)
              ├── Step 1: Terraform Init
              ├── Step 2: Terraform Plan
              └── Step 3: Terraform Apply
```

### Hierarchy Breakdown:
* **Stage:** High-level logical division (e.g., Dev, QA, Prod, Scan, Deploy). Stages can run sequentially or in parallel.
* **Job:** A collection of steps that runs on a single pipeline **Agent/Runner**.
* **Step / Task:** The granular atomic execution unit (e.g., executing a PowerShell script, running a CLI command).

---

## 3. Pipeline Runners: Microsoft-Hosted vs. Self-Hosted

* **Microsoft-Hosted Agents:** Fresh, disposable VMs managed by Azure; wiped clean after each job run. Fast setup, but limited network connectivity to private VNets.
* **Self-Hosted Agents:** Your own VM or server installed in a private Azure Virtual Network; persistent, faster cache, and can access private cloud resources directly without public exposure.
