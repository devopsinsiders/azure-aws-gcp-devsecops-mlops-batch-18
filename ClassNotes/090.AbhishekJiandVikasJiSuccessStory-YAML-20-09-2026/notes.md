# 🏆 Enterprise YAML Pipelines: Templates, Variable Groups & Multi-Environment Deployments

> **Session Context:** Celebrating batch success stories, building DRY enterprise pipelines using templates, parameterized triggers, and Variable Groups.
> **Reference File:** `diagram.pdf`

---

## 1. Real Batch Success Stories & Inspiration

* Dedicated focus on mastering Terraform, Git branching, and YAML pipelines leads directly to senior DevSecOps job offers.
* Consistency in writing daily technical diaries and conducting mock interviews yields measurable career breakthroughs.

---

## 2. DRY Pipelines: Reusable YAML Templates

Instead of copy-pasting 200 lines of pipeline code across Dev, QA, and Prod, use **YAML Templates**:

```yaml
# templates/terraform-deploy-template.yaml
parameters:
  - name: environment
    type: string
  - name: serviceConnection
    type: string

steps:
  - script: |
      cd environments/${{ parameters.environment }}
      terraform init
      terraform plan -out=tfplan
    displayName: 'Terraform Plan for ${{ parameters.environment }}'
```

### Main Pipeline Calling the Template:
```yaml
stages:
  - stage: Deploy_Dev
    jobs:
      - job: Dev
        steps:
          - template: templates/terraform-deploy-template.yaml
            parameters:
              environment: 'dev'
              serviceConnection: 'sc-azure-dev'

  - stage: Deploy_Prod
    dependsOn: Deploy_Dev
    jobs:
      - job: Prod
        steps:
          - template: templates/terraform-deploy-template.yaml
            parameters:
              environment: 'prod'
              serviceConnection: 'sc-azure-prod'
```

---

## 3. Variable Groups & Key Vault Linking

* **Variable Groups (`Pipelines -> Library`):** Share variables across multiple pipelines.
* **Link Secrets:** Variable Groups can link directly to an **Azure Key Vault** to fetch secrets automatically during pipeline runs without storing credentials in plaintext!
