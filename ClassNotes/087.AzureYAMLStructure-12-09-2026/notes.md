# 📜 Azure DevOps YAML Pipeline Structure & Hierarchy

> **Session Context:** Deep dive into Azure DevOps YAML schema, Stages, Jobs, Steps, Tasks, stage dependencies, and conditional execution.
> **Reference File:** `diagram.pdf`

---

## 1. The 4-Tier YAML Pipeline Hierarchy

```
pipeline.yaml
  │
  ├── stage: Scan
  │     └── job: SecurityScan
  │           └── steps:
  │                 ├── task: tfsec@1
  │                 └── task: tflint@1
  │
  ├── stage: Plan (dependsOn: Scan)
  │     └── job: TerraformPlan
  │           └── steps:
  │                 ├── task: TerraformCLI@0 (init)
  │                 └── task: TerraformCLI@0 (plan)
  │
  └── stage: Apply (dependsOn: Plan, condition: branch == main)
        └── job: TerraformApply
              └── steps:
                    └── task: TerraformCLI@0 (apply)
```

---

## 2. Anatomy of YAML Building Blocks

| Level | Purpose | Example |
| :--- | :--- | :--- |
| **Stage** | High-level business phase; can have approval gates | `stage: Production_Deployment` |
| **Job** | Runs on a specific Agent pool/runner | `job: Terraform_Plan_Job` |
| **Step** | Linear sequence of operations inside a Job | `steps:` |
| **Task** | Pre-packaged automation module with inputs | `task: AzureCLI@2` |
| **Script** | Raw shell/PowerShell command block | `script: terraform init` |

---

## 3. Stage Dependencies & Conditional Execution

* **`dependsOn`:** Enforces sequential execution order between stages or jobs:
  ```yaml
  stages:
  - stage: Scan
  - stage: Plan
    dependsOn: Scan
  - stage: Apply
    dependsOn: Plan
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  ```
* **Branch Conditions:** Guarantees destructive actions like `terraform apply` execute **only** when code merges into `main`.
