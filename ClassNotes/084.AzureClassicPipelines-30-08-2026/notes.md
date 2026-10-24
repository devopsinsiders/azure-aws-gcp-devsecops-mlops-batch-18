# ⚙️ Azure Classic Pipelines & Automated Operational Automation

> **Session Context:** Designing operational pipeline automation beyond Terraform (VM schedules, orphan resource cleanup, cost alerts), and building custom PowerShell scripts.
> **Reference File:** `diagram.pdf`

---

## 1. Real-World Cloud Automation Scenarios

Pipelines are not only for code deployment; they are widely used for recurring cloud maintenance:

```
+---------------------------------------------------------------------------------+
|                       Automated Cloud Operational Tasks                         |
|                                                                                 |
| 1. Cost Optimization: Automatically stop Non-Prod VMs at 8:00 PM and start      |
|    them at 8:00 AM on weekdays (saves 65% compute cost).                       |
| 2. Hygiene & Cleanup: Scan for unattached Azure Managed Disks and delete orphans.|
| 3. Security Audits: Scan for unused Public IPs and exposed NSG rules.           |
| 4. Certificate Management: Alert 30 days before TLS/SSL certificates expire.    |
| 5. FinOps Reporting: Generate weekly subscription cost reports and email to     |
|    management.                                                                  |
| 6. Configuration Management: Execute Ansible playbooks across fleet of VMs.     |
+---------------------------------------------------------------------------------+
```

---

## 2. Practical Lab: Automated Script Pipeline Workflow

```
1. Requirement Analysis:
   Parse an employee Excel/CSV file, detect birthdays, and post Slack reminders.
   (Similarly: Read resource definitions from CSV and generate terraform.tfvars).

2. Manual Testing:
   Write and test the PowerShell / Bash script locally on your workstation.

3. Git Integration:
   Push script to Azure Repos.

4. Pipeline Setup:
   Create an Azure Pipeline -> Select Repository and Branch -> Choose Agent Pool.

5. Add Tasks:
   Add PowerShell task -> Select script from repo -> Set schedule trigger (Cron).
```

### Golden Rule of Pipeline Engineering:
> *"Pehle process ko manually feel karna hai; fir pipeline me wahi same commands utha ke automate kar dena hai!"*
