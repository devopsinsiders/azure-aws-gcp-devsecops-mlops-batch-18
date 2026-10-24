# 🖥️ Azure Classic Pipelines Deep Dive: Agent Workspace & Service Principals

> **Session Context:** Complete execution lifecycle of Classic UI pipelines, agent file system structures (`_work/1/s`), and Entra ID Service Principal authentication.
> **Reference File:** `diagram.pdf`

---

## 1. Agent File System Internals: Where Does Code Live?

When an Azure Pipeline agent executes a job, it constructs a localized working workspace:

```
C:/ (or /home/agent)/
└── _work/
    ├── 1/                       # Pipeline Build ID folder
    │   ├── s/                   # Source Directory: $(Build.SourcesDirectory)
    │   │   ├── environments/    # Cloned Git Repository files live here!
    │   │   │   └── preprod/
    │   │   └── modules/
    │   ├── b/                   # Binaries Directory: $(Build.BinariesDirectory)
    │   └── a/                   # Artifact Staging: $(Build.ArtifactStagingDirectory)
    └── _tasks/                  # Cached Azure DevOps Tasks
```

---

## 2. Authenticating Pipelines to Azure: Entra ID App Registrations

An automated pipeline cannot enter interactive 2FA/MFA credentials (`az login`). It requires an unattended identity: a **Service Principal**.

```
+------------------------------------+
|     Microsoft Entra ID (Azure AD)  |
|                                    |
|  App Registration: plan-checker    |
|  - Application (Client) ID         |
|  - Directory (Tenant) ID           |
|  - Client Secret (Password)        |
+-----------------+------------------+
                  |
                  | Assigned "Contributor" Role on Target Subscription
                  v
+------------------------------------+
|    Target Azure Subscription       |
|    (Resources can be managed)      |
+------------------------------------+
```

### Pipeline Script Task:
```bash
az login --service-principal   -u "40084669-77f8-484d-a7d2-2ba4f1f64da9"   -p "$CLIENT_SECRET"   --tenant "$TENANT_ID"
```
