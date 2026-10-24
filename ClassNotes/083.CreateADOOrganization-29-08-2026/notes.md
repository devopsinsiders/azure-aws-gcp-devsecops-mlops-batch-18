# 🏢 Azure DevOps Organization Setup, Entra ID & Agent Pools

> **Session Context:** Setting up Azure DevOps Organizations, linking Entra ID directories, Project boundaries, and configuring Agent Pools.
> **Reference File:** `diagram.pdf`

---

## 1. Enterprise Hierarchy: Azure Portal vs. Azure DevOps

```
         Azure Portal (portal.azure.com)          Azure DevOps (dev.azure.com)
         +-----------------------------+          +--------------------------+
         | Tenant Root Group           |          | Organization             |
         |   └── Management Groups     |          | (e.g., Vistara Tech)     |
         |         └── Subscriptions   |          |   └── Projects           |
         |               └── RGs       |          |         ├── Repos        |
         +--------------+--------------+          |         ├── Pipelines    |
                        |                         |         ├── Boards       |
                        | Linked via Identity     |         └── Artifacts    |
                        v                         +-------------+------------+
         +-----------------------------+                        |
         | Microsoft Entra ID Directory| <----------------------+
         | (Users, Groups, SPNs, RBAC) |
         +-----------------------------+
```

---

## 2. Organization & Project Structure

* **Organization (`dev.azure.com/<OrgName>`):** The enterprise top-level tenant boundary. Usually linked to the corporate Microsoft Entra ID tenant.
* **Projects:** Isolated administrative domains under an Organization (e.g., `Vistara-Sense-IOT`, `Axion-Refinery-App`).
* **Services inside each Project:**
  * **Azure Repos:** Git version control repositories.
  * **Azure Pipelines:** CI/CD automation engine.
  * **Azure Boards:** Agile planning, epics, features, user stories, and sprints.
  * **Azure Artifacts:** Package management feeds (NuGet, npm, Maven).

---

## 3. Agent Pools Architecture

* **Agent Pool:** A container of compute runners available across the Organization or Project.
* **Self-Hosted Agent Setup:**
  1. Navigate to *Project Settings* $\to$ *Agent Pools* $\to$ *Add pool*.
  2. Download agent zip package to your local VM or server.
  3. Generate a **Personal Access Token (PAT)** in Azure DevOps.
  4. Run `./config.cmd` or `./config.sh` and attach the runner to your custom pool.
