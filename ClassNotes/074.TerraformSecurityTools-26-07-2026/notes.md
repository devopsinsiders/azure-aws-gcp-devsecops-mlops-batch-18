# 🛡️ DevSecOps Shift-Left: Static Code Analysis & Secret Scanners

> **Session Context:** Integrating security scanners into Terraform development workflows, static analysis tools comparison, and daily discipline for career breakthrough.
> **Reference File:** `diagram.pdf`

---

## 1. Why "Shift-Left" Security in Infrastructure as Code?

Traditional security models inspected infrastructure after deployment. **Shift-Left Security** moves security checks directly into the developer's workstation and pre-merge CI pipelines.

```
Developer Laptop              Git Pull Request               Cloud Deployment
+------------------+         +------------------+         +--------------------+
| Pre-Commit Hooks | ------> | CI Scan Pipeline | ------> | Azure Cloud        |
| (tfsec, tflint)  |         | (checkov, leaks) |         | (Zero Vulnerable   |
+------------------+         +------------------+         |  Resources)        |
                                                          +--------------------+
```

---

## 2. Core DevSecOps Security Tools Matrix

| Tool | Focus Area | What it Catches |
| :--- | :--- | :--- |
| **`tfsec`** | Terraform Security Scanner | Overly permissive NSGs (Port 22 open to `0.0.0.0/0`), unencrypted storage, missing access logs |
| **`checkov`** | Multi-IaC Security Scanner | Compliance benchmarking (CIS, HIPAA, PCI-DSS) across Terraform, Kubernetes, and ARM |
| **`tflint`** | Terraform Linter | Invalid instance types, deprecated syntax, module naming errors |
| **`trufflehog`** | Secret Scanner | High-entropy strings, passwords, AWS/Azure access keys in commit history |
| **`gitleaks`** | Fast Git Secret Scanner | API tokens and private keys in staged files |
| **`infracost`** | Cost Estimation | Forecasts exact dollar cost changes before running `terraform apply` |

---

## 3. Daily Practice & Interview Mindset

* **Daily Discipline:** Apply to 50 target companies daily; visit careers pages directly.
* **Fail Forward:** Interview failures are required milestones; each failed interview reveals gaps to master.
* **Focus on Value:** Deeply master Terraform, Azure networking, and pipeline security rather than superficial tool breadth.
