# 🌿 Git Branching, Branch Protection & Trunk-Based Development

> **Session Context:** Main branch protection rules, branch isolation, feature branch lifecycle, and repository hygiene.
> **Reference File:** `diagram.pdf`

---

## 1. The Cardinal Rule of Enterprise Version Control

> ⚠️ **"Nadi kinare saanp hai, aur main branch me push karna maha paap hai!"**
> Direct pushes to the `main` branch are strictly prohibited across enterprise engineering squads.

---

## 2. Setting Up Enterprise Branch Protection Rules

In GitHub or Azure Repos, enforce policy on `main`:
1. **Require a Pull Request before merging:** Blocks direct `git push origin main`.
2. **Require minimum number of approvers:** At least 1 (or 2) senior peer reviews.
3. **Check for linked work items:** Enforces traceability to JIRA / Azure Boards tasks.
4. **Require status checks to pass:** Blocks merge if security scanning or Terraform Plan fails.

---

## 3. Feature Branch Lifecycle: Adding a New Resource Group

```
Main Branch (Clean, Stable)
     |
     | git checkout -b feature/new-rg
     v
Feature Branch:
  1. Modify terraform.tfvars (add new resource group definition in map)
  2. git status                      # Verify modified files
  3. git add .                       # Stage changes
  4. git commit -m "feat: added new rg in dev tfvars"
  5. git push -u origin feature/new-rg
     |
     v
Raise Pull Request (PR) to merge into Main
```
