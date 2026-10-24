# 🔄 Azure Pipelines: Predefined Variables & Service Connections

> **Session Context:** Transitioning from Classic to YAML, mastering predefined system variables (`$(Build.SourcesDirectory)`), and replacing secrets with Service Connections.
> **Reference File:** `diagram.pdf`

---

## 1. Essential Predefined Variables in Azure Pipelines

Azure Pipelines provides built-in environment variables available across all tasks:

| Predefined Variable | What It Points To | Practical Usage |
| :--- | :--- | :--- |
| **`$(Build.SourcesDirectory)`** | Local path on the agent where repository files are cloned (e.g., `C:/_work/20/s`) | `cd $(Build.SourcesDirectory)/environments/preprod` |
| **`$(Build.ArtifactStagingDirectory)`** | Directory where output artifacts should be copied before publishing | Staging `tfplan` binary files |
| **`$(Build.BuildId)`** | Unique runtime identifier for the pipeline execution run | Tagging Docker images or state files |
| **`$(Build.SourceBranchName)`** | Name of the Git branch triggering the pipeline | Writing conditional deployment gates |

---

## 2. Replacing Hardcoded Credentials with Service Connections

```
❌ Hardcoded Client Secret in Pipeline Tasks (Security Anti-Pattern):
az login --service-principal -u $(client_id) -p $(client_secret) --tenant $(tenant_id)

                                      VS

✅ Modern Azure DevOps Service Connection (Enterprise Standard):
- Stores credentials securely in Azure DevOps encrypted vault.
- Tasks reference the Service Connection by logical name:
  azureSubscription: 'axion-azure-prod-sc'
```

---

## 3. The Future: Workload Identity Federation (OIDC)

* **Legacy Service Connections:** Use long-lived client secrets that expire every 1–2 years and require rotation.
* **Workload Identity Federation (WIF):** Uses OpenID Connect (OIDC) tokens. Azure DevOps exchanges a short-lived cryptographically signed token with Microsoft Entra ID. **Zero passwords or secrets to store, manage, or rotate!**
