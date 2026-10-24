# 🔁 End-to-End Git Flow: PR Pipelines & Conditional Gating

> **Session Context:** Automated Pull Request pipelines, conditional stage execution, preventing unintended Terraform Apply runs, and peer review standards.
> **Reference File:** `diagram.pdf`

---

## 1. Feature PR Automated Pipeline Architecture

When a developer pushes code to a `feature/*` branch and opens a Pull Request, an automated PR pipeline executes:

```
Developer Pushes to feature/* Branch
                  |
                  v
+-------------------------------------------------------------+
|               Pull Request Verification Pipeline            |
|                                                             |
|  Stage 1: Scan Stage                                        |
|  - Run tfsec (Security misconfigurations)                   |
|  - Run tflint (HCL best practices)                          |
|  - Run gitleaks (Secret scanning)                           |
|  - Run infracost (Cost variance estimation)                 |
|                             |                               |
|                             v                               |
|  Stage 2: Plan Stage                                        |
|  - terraform init                                           |
|  - terraform validate                                       |
|  - terraform plan (Outputs plan artifact)                   |
|                             |                               |
|                             x                               |
|  Stage 3: Apply Stage DOES NOT RUN!                         |
|  (Condition: eq(variables['Build.SourceBranch'], 'main'))   |
+-------------------------------------------------------------+
```

---

## 2. Why the Apply Stage is Strictly Blocked on Feature Branches

* **Infrastructure Safety:** A feature branch contains unreviewed, potentially buggy code.
* **State Pollution:** Applying from a feature branch alters shared cloud infrastructure without architect approval.
* **Conditional Logic:** The pipeline YAML evaluates branch conditions:
  ```yaml
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  ```

---

## 3. Human Review & Merge Flow

1. Lead Architect inspects the PR diff, security scan report, and `terraform plan` output.
2. If approved, the PR merges into `main`.
3. The merge event triggers the production CI/CD pipeline on `main`, which safely executes:
   $$\text{Scan} \longrightarrow \text{Plan} \longrightarrow \text{Manual Approval} \longrightarrow \text{Apply}$$
