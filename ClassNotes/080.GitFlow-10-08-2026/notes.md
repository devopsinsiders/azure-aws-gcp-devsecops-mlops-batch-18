# 🔀 Git Flow with Manual Approval Gates & Multi-Stage Deployment

> **Session Context:** Designing production CI/CD approval workflows, manual gates in Azure Pipelines, plan-checker validation, and applying to cloud.
> **Reference File:** `diagram.pdf`

---

## 1. The Production Gated Pipeline Flow

```
+---------------------------------------------------------------------------------+
|                       Main Branch Deployment Pipeline                           |
|                                                                                 |
| +--------------------+    +--------------------+    +------------------------+  |
| | Stage 1: Security  |    | Stage 2: Plan      |    | Stage 3: Manual Gate   |  |
| | - tfsec            | -> | - terraform init   | -> | - Lead Architect       |  |
| | - gitleaks         |    | - terraform plan   |    |   inspects plan output |  |
| +--------------------+    +--------------------+    +-----------+------------+  |
|                                                                 |               |
|                                                                 | Approved      |
|                                                                 v               |
|                                                     +------------------------+  |
|                                                     | Stage 4: Apply Stage   |  |
|                                                     | - terraform apply      |  |
|                                                     |   --auto-approve       |  |
|                                                     +------------------------+  |
+---------------------------------------------------------------------------------+
```

---

## 2. Why Manual Approval Gates are Non-Negotiable

1. **Destructive Changes Check:** Verifies whether Terraform plans to destroy critical resources (`# azurerm_storage_account.st must be replaced`).
2. **Financial Control:** Ensures cost variances estimated by Infracost fit project budgets.
3. **Change Management Compliance:** Satisfies ITIL change approval requirements for production environments.
