# 🔐 Azure Key Vault Deep Dive: Secrets, Keys, RBAC & Endpoints

> **Session Context:** Enterprise secret management, Secrets vs Keys vs Certificates, Entra ID RBAC vs Vault Access Policies, and disaster recovery.
> **Reference File:** `diagram.pdf`

---

## 1. What is Azure Key Vault?

**Azure Key Vault** is a centralized cloud service for securely storing and accessing application secrets, encryption keys, and TLS/SSL certificates backed by Hardware Security Modules (FIPS 140-2 validated HSMs).

```
                      +-----------------------------+
                      |       Azure Key Vault       |
                      +--------------+--------------+
                                     |
         +---------------------------+---------------------------+
         |                           |                           |
+--------v--------+         +--------v--------+         +--------v--------+
|     Secrets     |         |      Keys       |         |  Certificates   |
| Passwords, API  |         | Cryptographic   |         | X.509 SSL/TLS   |
| tokens, DB URIs |         | encryption keys |         | certificates    |
+-----------------+         +-----------------+         +-----------------+
```

---

## 2. Entra ID RBAC vs. Vault Access Policies

| Feature | Legacy Vault Access Policies | Entra ID RBAC (Recommended) |
| :--- | :--- | :--- |
| **Granularity** | All-or-nothing per vault | Fine-grained per secret/key |
| **Role Separation** | Broad permissions | Specific roles (`Key Vault Secrets Officer`, `Crypto Officer`) |
| **Compliance** | Difficult to audit | Integrated with Microsoft Entra ID governance & PIM |
| **Management** | Configured in Key Vault blade | Configured via unified Azure IAM blade |

> 🔒 **Microsoft Recommendation:** Always use **Azure RBAC** for Key Vault access control to implement the principle of least privilege.
