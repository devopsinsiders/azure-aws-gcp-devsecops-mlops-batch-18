# 🌿 Git Fundamentals: Architecture, 3-Tree Model & Workflow

> **Session Context:** Core Git internals, the 3-tree architecture, tracked vs untracked lifecycle, and technical articulation techniques for senior interviews.
> **Reference File:** `diagram.pdf`

---

## 1. Technical Articulation: 30% Tech, 70% Explanation

> 💡 *"30% technology and 70% way of explanation. Agar aap 50 cheezein jante ho lekin Resource Group theek se explain nahi kar paa rahe, toh koi fayda nahi!"*
> Focus on clear, confident articulation of fundamentals: Cloud Adoption Framework, Terraform modularity, and Git branching.

---

## 2. Git 3-Stage Internal Architecture

Git manages code across three distinct logical trees on your workstation:

```
+--------------------+       git add <file>       +--------------------+
|  Working Directory | -------------------------> |    Staging Area    |
|  (Untracked/Edited)|                            |    (Index file)    |
+--------------------+                            +---------+----------+
          ^                                                 |
          |               git commit -m "..."               |
          |           +-------------------------------------+
          |           v
+---------+----------+                            +--------------------+
| Local Repository   | -------------------------> | Remote Repository  |
| (.git Commit Tree) |         git push           | (GitHub / ADO)     |
+--------------------+                            +--------------------+
```

### Zone Definitions:
1. **Working Directory:** The actual local folder on your filesystem where you modify files.
2. **Staging Area (Index):** A snapshot file caching changes prepared for the next commit.
3. **Local Repository (`.git`):** The local database storing immutable commit objects, trees, and blobs.
4. **Remote Repository:** The cloud-hosted central repository (Azure Repos, GitHub, GitLab).

---

## 3. Essential Git Lifecycle Commands

* `git init`: Initializes a fresh `.git` metadata directory.
* `git status`: Checks working tree status (untracked files vs staged files).
* `git add .`: Moves all modified/new files into the staging index.
* `git commit -m "feat: added modular storage account"`: Creates an immutable commit snapshot with a SHA-1 hash.
* `git log --oneline`: Displays compact commit history.
