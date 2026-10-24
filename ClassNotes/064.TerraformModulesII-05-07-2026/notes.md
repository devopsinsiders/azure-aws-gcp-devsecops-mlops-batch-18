# 🔄 Terraform Collaboration, State Sharing & CI/CD Pipeline Automation

> **Session Context:** The pain points of local Terraform execution, team state locking, and introduction of automated CI/CD scan-plan-apply pipelines.
> **Reference File:** `diagram.pdf`

---

## 1. The Dangers of Local Terraform Execution

```
               Local Laptop 1                        Local Laptop 2
               (Engineer Alice)                      (Engineer Bob)
                      |                                     |
                      | az login                            | az login
                      | terraform apply                     | terraform apply
                      v                                     v
                 +----+-------------------------------------+----+
                 |           Shared Remote State File            |
                 |             (Storage Account Blob)            |
                 +-----------------------+-----------------------+
                                         |
                                         v
                                    Azure Cloud
```

### Production Risks of Running Terraform Locally:
1. **State Locking Conflicts:** Two engineers running apply at the same time corrupt state.
2. **Missing Security Scans:** Local runs bypass security checks (hardcoded secrets, exposed ports).
3. **No Audit Trail:** No record of who ran what command or why changes occurred.
4. **Environment Drift:** Differences in local Terraform versions, plugins, or OS environments.

---

## 2. Automated Git & CI/CD Pipeline Workflow

```
+-------------------+      Git Push        +-------------------+
| Feature Branch    | -------------------> | Azure Repos /     |
| (Developer Code)  |                      | GitHub Repo       |
+-------------------+                      +---------+---------+
                                                     | Triggers PR Pipeline
                                           +---------v---------+
                                           | Automated Runner  |
                                           +---------+---------+
                                                     |
        +--------------------------------------------+--------------------------------------------+
        |                                                                                         |
+-------v-------------------------+                                             +-----------------v---------------+
| Stage 1: Security & Quality     |                                             | Stage 2: Terraform Plan         |
| - tfsec (Security scan)         |                                             | - terraform init                |
| - tflint (Best practice linter) | ------------------------------------------> | - terraform validate            |
| - terratest / checkov           |                                             | - terraform plan                |
+---------------------------------+                                             +-----------------+---------------+
                                                                                                  |
                                                                                        PR Approved & Merged
                                                                                                  |
                                                                                +-----------------v---------------+
                                                                                | Stage 3: Approval & Apply       |
                                                                                | - Manual Approval Gate          |
                                                                                | - terraform apply --auto-approve|
                                                                                +---------------------------------+
```
