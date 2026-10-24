# 📝 YAML Fundamentals for DevOps Engineers

> **Session Context:** Syntax rules, indentation mechanics, data serialization, and why modern DevOps tools standardize on YAML.
> **Reference File:** `diagram.pdf`

---

## 1. What is YAML?

**YAML** stands for *YAML Ain't Markup Language*. It is a human-readable data serialization format designed for configuration management.

### Why does DevOps use YAML?
* **Simplicity:** Focuses purely on declarative configuration rather than complex programming syntax.
* **Readability:** Clean structure without XML tags or JSON braces/commas.
* **Cross-Platform:** Universal format across Azure DevOps, GitHub Actions, Kubernetes manifests, Ansible, and Docker Compose.

---

## 2. The Core Syntax Rules of YAML

1. **Colons (`:`):** Separate keys from values (`name: jhansaram`). Always follow the colon with a space!
2. **Indentation:** Uses spaces (typically **2 spaces** per level). **Tabs are strictly forbidden!**
3. **Hyphens (`-`):** Denote items in an ordered list or array:
   ```yaml
   tools:
     - terraform
     - azure-cli
     - docker
   ```
4. **Data Types:**
   * **Strings:** `environment: production`
   * **Numbers:** `replicas: 3`
   * **Booleans:** `auto_approve: true`
   * **Dictionaries / Maps:** Key-value pairs indented under a parent key.
