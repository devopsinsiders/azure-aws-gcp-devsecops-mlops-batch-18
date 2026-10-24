# 🎛️ Parameterized Pipelines & Reusable Enterprise Architecture

> **Session Context:** Creating parameterized runtime pipelines, dynamic environment targeting (Dev/QA/Prod), and Infracost financial gates.
> **Reference File:** `diagram.pdf`

---

## 1. What are Pipeline Parameters?

Parameters provide runtime flexibility, allowing engineers to select deployment targets, actions, or resource flags when manually triggering a pipeline.

```yaml
parameters:
  - name: environment
    displayName: 'Target Deployment Environment'
    type: string
    default: 'dev'
    values:
      - dev
      - qa
      - prod

  - name: action
    displayName: 'Terraform Action'
    type: string
    default: 'plan'
    values:
      - plan
      - apply
      - destroy
```

---

## 2. Dynamically Targeting Environments

```yaml
steps:
  - script: |
      echo "Deploying to ${{ parameters.environment }}"
      cd environments/${{ parameters.environment }}
      terraform init
      terraform ${{ parameters.action }}
    displayName: 'Execute Terraform on ${{ parameters.environment }}'
```

### Enterprise Value:
* Eliminates the need to maintain 10 separate pipeline files for 10 projects or environments.
* Centralizes security policies, cost scanning, and linting rules in one standard pipeline.
