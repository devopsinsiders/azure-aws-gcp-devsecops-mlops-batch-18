# 🚀 End-to-End Terraform Multi-Stage YAML Pipelines

> **Session Context:** Moving from Classic UI to YAML as Code, automating the Axion Systems 3-tier landing zone, and Trunk-Based PR gating.
> **Reference File:** `diagram.pdf`

---

## 1. Why YAML Pipelines Replace Classic UI

* **Version Controlled (Pipeline as Code):** The `.azure-pipelines.yaml` file resides inside the Git repository with the Terraform code.
* **Branching & PR Testing:** Changing a pipeline in a feature branch can be tested without modifying production pipelines.
* **Auditability & History:** Every pipeline change is tracked in Git history with commit authors.

---

## 2. Complete Enterprise CI/CD Pipeline Architecture

```
Developer Workstation
      |
      | git push origin feature/appgw-update
      v
Azure Repos (Feature Branch)
      |
      | Trigger PR Validation
      v
+-------------------------------------------------------------+
| Pull Request Pipeline (Scan & Plan Only)                    |
| - Stage 1: Shift-Left Scan (tfsec, gitleaks, tflint)        |
| - Stage 2: Terraform Plan (Outputs plan for reviewer)       |
+------------------------------+------------------------------+
                               |
                        PR Approved & Merged
                               |
                               v
Azure Repos (Main Branch)
      |
      | Trigger Main Release Pipeline
      v
+-------------------------------------------------------------+
| Production Deployment Pipeline                              |
| - Stage 1: Shift-Left Scan                                  |
| - Stage 2: Terraform Plan                                   |
| - Stage 3: Manual Approval Gate (Lead Architect signs off)  |
| - Stage 4: Terraform Apply (--auto-approve)                 |
+-------------------------------------------------------------+
```
