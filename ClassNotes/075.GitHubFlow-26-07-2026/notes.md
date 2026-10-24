# 🐙 GitHub Flow, Branch Protection & CI/CD Gating Rules

> **Session Context:** Source Code Management principles, Git 3-stage lifecycle, Trunk-Based development, branch protection policies, and automated PR pipelines.
> **Reference File:** `diagram.pdf`

---

## 1. The 7 Enterprise Benefits of Source Code Management (SCM)

1. **Version History:** Tracks every line addition, modification, and deletion.
2. **Disaster Backup:** Cloud repository acts as safe distributed backup.
3. **Team Collaboration:** Enables dozens of engineers to develop simultaneously.
4. **Conflict Management:** Automated merge conflict resolution workflows.
5. **Rollback Capabilities:** Revert faulty commits instantly in production.
6. **Branch Isolation:** Develop features in complete isolation without affecting `main`.
7. **Peer Code Review:** Mandatory Pull Request reviews enforce code quality and knowledge sharing.

---

## 2. Git Internal Architecture: The 3 Stages

```
+-------------------+       git add .       +-------------------+
| Working Directory | --------------------> |   Staging Area    |
| (Modified Files)  |                       |  (Tracked Files)  |
+-------------------+                       +---------+---------+
                                                      |
                                                      | git commit -m "..."
                                                      v
+-------------------+       git push        +-------------------+
|  Remote GitHub /  | <-------------------- |  Committed Area   |
|  Azure Repos      |                       |   (Local Git)     |
+-------------------+                       +-------------------+
```

---

## 3. The Golden Rule of Branching Strategy

> ⛔ **"Main branch me push karna maha paap hai!"**
> (Directly pushing code or committing to the `main` branch is strictly prohibited in enterprise engineering).

### Branch Protection Policy Configuration:
* Require Pull Request before merging to `main`.
* Require at least **1–2 peer approvals**.
* Require all CI status checks (Security Scans & Terraform Plan) to pass.
* Restrict who can push to matching branches.

---

## 4. End-to-End Feature PR Workflow

```
1. Developer creates feature branch from main:
   git checkout -b feature/new-rg

2. Developer makes changes and pushes:
   git add . && git commit -m "added resource group" && git push -u origin feature/new-rg

3. Automated Pull Request Pipeline triggers:
   ├── Stage 1: Security Scan (tfsec, gitleaks, tflint, infracost)
   └── Stage 2: Terraform Plan (init, fmt, validate, plan output)

4. Developer creates Pull Request (PR) in GitHub / Azure Repos.
5. Lead Architect reviews code diff, scan report, and plan output.
6. Lead approves PR -> Code merges into main.
7. Main branch CI/CD pipeline triggers:
   ├── Stage 1: Scan
   ├── Stage 2: Plan
   ├── Stage 3: Manual Approval Gate
   └── Stage 4: Terraform Apply (Auto-approved)
```
