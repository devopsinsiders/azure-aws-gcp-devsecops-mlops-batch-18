# 🛠️ Hands-on Multi-Stage Terraform YAML Pipeline in Azure DevOps

> **Session Context:** Step-by-step implementation of a 4-stage Terraform YAML pipeline with static scanning, planning, approval gates, and auto-apply.
> **Reference File:** `diagram.pdf`

---

## 1. Full Production Pipeline YAML Implementation

```yaml
trigger:
  branches:
    include:
      - main
      - feature/*

pool:
  vmImage: 'ubuntu-latest'

variables:
  - group: 'terraform-common-vg'

stages:
  # Stage 1: Security & Quality Scanning
  - stage: Scan
    displayName: 'Static Security & Linting Scan'
    jobs:
      - job: SecurityScan
        steps:
          - script: |
              curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
              tfsec .
            displayName: 'Run tfsec Security Scan'
          - script: |
              curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
              tflint --init && tflint
            displayName: 'Run tflint Linter'

  # Stage 2: Terraform Plan
  - stage: Plan
    displayName: 'Terraform Init & Plan'
    dependsOn: Scan
    jobs:
      - job: TerraformPlan
        steps:
          - task: TerraformInstaller@0
            inputs:
              terraformVersion: '1.7.0'
          - script: |
              cd environments/preprod
              terraform init
              terraform validate
              terraform plan -out=tfplan
            displayName: 'Generate Plan'

  # Stage 3: Approval & Apply (Main Branch Only)
  - stage: Apply
    displayName: 'Terraform Apply to Azure'
    dependsOn: Plan
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: ApplyToAzure
        environment: 'Preprod-Approval-Environment'  # Enforces Azure DevOps Manual Approvals
        strategy:
          runOnce:
            deploy:
              steps:
                - script: |
                    cd environments/preprod
                    terraform apply --auto-approve tfplan
                  displayName: 'Apply Infrastructure'
```
