# 🔐 Terraform Secrets Hardening: Azure Key Vault Integration

> **Session Context:** Eliminating hardcoded secrets from Terraform code, automated secret scanning tools, and retrieving credentials dynamically from Azure Key Vault.
> **Reference File:** `diagram.pdf`

---

## 1. The Danger of Hardcoded Credentials ("Bewafaa Password")

```
❌ ANTI-PATTERN:
resource "azurerm_windows_virtual_machine" "vm" {
  admin_username = "adminuser"
  admin_password = "P@ssw0rd1234!"  # HARDCODED SECRET IN CODE OR TFVARS!
}
```

### Why Hardcoded Passwords in Git are Catastrophic:
* Git commits are immutable; secrets persist in commit history forever.
* Anyone with repo access (developers, contractors, CI runners) can inspect credentials.
* Automated bots continuously scan public and private repos to compromise cloud subscriptions.

---

## 2. Automated Secret Scanning Tools

Before code is ever committed, automated scanners must inspect files:
* **TruffleHog:** Scans git repositories for high-entropy strings, API keys, and private credentials.
* **Gitleaks:** Fast, lightweight secret detection tool designed for pre-commit hooks and CI/CD pipelines.
* **GitGuardian:** Automated secret scanning platform with real-time alerting.
* **detect-secrets:** Python-based baseline scanner that flags newly added credentials.

---

## 3. The Secure Pattern: Azure Key Vault + Data Blocks

```
                      +-----------------------------+
                      |       Azure Key Vault       |
                      | Secret: "vm-admin-password" |
                      +--------------+--------------+
                                     ^
                                     | data "azurerm_key_vault_secret"
                      +--------------+--------------+
                      |        Terraform Code       |
                      |  Reads secret into memory   |
                      +--------------+--------------+
                                     |
                                     v
                      +-----------------------------+
                      |     Azure VM Provisioning   |
                      | admin_password = data...    |
                      +-----------------------------+
```

### Implementation HCL:
```hcl
data "azurerm_key_vault" "kv" {
  name                = "kv-axion-prod"
  resource_group_name = "rg-security"
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "vm-workload-01"
  resource_group_name             = "rg-workload"
  location                        = "centralindia"
  size                            = "Standard_D2s_v3"
  admin_username                  = "devopsadmin"
  admin_password                  = data.azurerm_key_vault_secret.vm_password.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]
  # ...
}
```
