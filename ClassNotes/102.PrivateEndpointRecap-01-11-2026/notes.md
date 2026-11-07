# 🔄 Azure Private Endpoint Recap, DNS Resolution & Cost Governance

> **Session Date:** 01-11-2026  
> **Session Context:** Hands-on recap of Azure Private Endpoints with multi-VNet peering, DNS resolution pitfalls, Private DNS Zone integration (`privatelink.blob.core.windows.net`), student architectural Q&A, and Pay-As-You-Go budget & security rules.  
> **Reference Diagram:** [`diagram.pdf`](file:///c:/DevOpsInsiders/Batch18/azure-aws-gcp-devsecops-mlops-batch-18/ClassNotes/102.PrivateEndpointRecap-01-11-2026/diagram.pdf)

---

## 📌 Mindset & Cloud Cost Governance

> *"Medical Urgency ke alawa kahi jaldibaaji nahi karna hai!"*  
> Take your time to understand every architectural brick before deploying, and always adhere to strict security hygiene when practicing in cloud environments.

### 💰 How to Practice on Pay-As-You-Go Without Breaking the Bank:
1. **Enforce MFA (Multi-Factor Authentication):** Top priority to prevent account compromise and unauthorized crypto-mining or resource spin-ups.
2. **Never Share Credentials:** Protect IDs, passwords, and service principal secrets.
3. **No Unapproved Onboarding:** Do not invite or onboard random test users into your Entra ID tenant.
4. **Minimize App Registrations:** Do not leave unused App Registrations or excessive role assignments sitting in your subscription.
5. **Automated Teardown Script:** As soon as your practice session concludes, execute immediate teardown of all test resource groups:
   ```powershell
   az group list --query "[].name" -o tsv | ForEach-Object { az group delete --name $_ --yes --no-wait }
   ```

---

## 1. Multi-VNet Private Endpoint Architecture

The classroom lab demonstrates how an enterprise workload residing in one VNet connects securely to an Azure PaaS service (Azure Blob Storage) deployed behind a Private Endpoint inside a central Hub VNet.

```
+---------------------------------------------------------------------------------------------------+
|  Workload VNet (10.143.0.0/16)                                                                    |
|                                                                                                   |
|    +------------------------------------------------------+                                       |
|    | Subnet: VM Subnet (10.143.0.0/24)                    |                                       |
|    |                                                      |                                       |
|    |   +----------------------------------------------+   |                                       |
|    |   | Virtual Machine (Workload VM)                |   |                                       |
|    |   | Private IP: 10.143.0.4                       |   |                                       |
|    |   +----------------------------------------------+   |                                       |
|    +------------------------------------------------------+                                       |
+---------------------------------^-----------------------------------------------------------------+
                                  |
                                  | Bidirectional VNet Peering
                                  v
+---------------------------------------------------------------------------------------------------+
|  Central Hub VNet (10.124.0.0/16)                                                                 |
|                                                                                                   |
|    +------------------------------------------------------+                                       |
|    | Subnet: PE Subnet (10.124.0.0/24)                    |                                       |
|    |                                                      |                                       |
|    |   +----------------------------------------------+   |        Azure Private Link             |
|    |   | Private Endpoint NIC                         |---|------------------------------+        |
|    |   | Private IP: 10.124.0.4                       |   |                              |        |
|    |   +----------------------------------------------+   |                              v        |
|    +------------------------------------------------------+                    +----------------+ |
|                                                                                | Azure Storage  | |
|    +------------------------------------------------------+                    | Account        | |
|    | Azure Private DNS Zone:                              |                    | distorage654321| |
|    | privatelink.blob.core.windows.net                    |                    | (blob service) | |
|    | A Record: distorage654321 -> 10.124.0.4              |                    +----------------+ |
|    | Linked VNets: Workload VNet + Hub VNet               |                                       |
|    +------------------------------------------------------+                                       |
+---------------------------------------------------------------------------------------------------+
```

---

## 2. The 7-Step Hands-On Implementation Flow

Follow this exact sequence to deploy and validate private connectivity:

```
[ Step 1: Create RG ]
         |
         v
[ Step 2: Create 2 VNets (Hub VNet & Workload VNet) ]
         |
         v
[ Step 3: Deploy VM in Workload VNet Subnet ]
         |
         v
[ Step 4: Configure Bidirectional VNet Peering ]
         |
         v
[ Step 5: Provision Private Endpoint for Storage Account in Hub PE Subnet (IP: 10.124.0.4) ]
         |
         v
[ Step 6: Test Name Resolution (nslookup) from VM ]
         |
         +--> Issue: Resolves to Public IP without DNS Zone!
         |
         v
[ Step 7: Create Private DNS Zone & Link Both VNets -> Name maps to 10.124.0.4 ]
```

### Detailed Breakdown:
1. **Create Resource Group:** Unified container for managing and cleanly destroying the lab resources.
2. **Create Two Virtual Networks:**
   - `Workload VNet` (`10.143.0.0/16`) $\rightarrow$ Subnet: `VM Subnet` (`10.143.0.0/24`).
   - `Hub VNet` (`10.124.0.0/16`) $\rightarrow$ Subnet: `PE Subnet` (`10.124.0.0/24`).
3. **Deploy Workload VM:** Host application or test client inside `VM Subnet`.
4. **Peer Both VNets:** Enable two-way traffic flow so machines in `Workload VNet` can reach IPs in `Hub VNet`.
5. **Create Storage Account & Private Endpoint:**
   - Storage account: `distorage654321`.
   - Sub-resource: `blob`.
   - Target Subnet: `PE Subnet` in `Hub VNet`.
   - Azure binds a private NIC with private IP `10.124.0.4`.
6. **Perform DNS Test (`nslookup`):**
   - Querying `distorage654321.blob.core.windows.net` still queries public DNS and returns public IP `20.150.114.97` or connection is blocked if public access is disabled!
7. **Configure Private DNS Zone:**
   - Zone name: `privatelink.blob.core.windows.net`.
   - Add `A` record: Host `distorage654321` $\rightarrow$ IP `10.124.0.4`.
   - Link the Private DNS Zone to both VNets (`Hub VNet` and `Workload VNet`).
   - Re-running `nslookup` now successfully resolves to `10.124.0.4`.

---

## 3. Student Classroom Q&A: Service Endpoint vs. Private Endpoint

> ❓ **Noor Alam's Question:**  
> *"Sir, I understand this flow of service endpoint, but what is the motto of using a private endpoint over a service endpoint?"*

### Key Comparison & Architectural Justification:

| Evaluation Criteria | Service Endpoint | Private Endpoint (Private Link) |
| :--- | :--- | :--- |
| **Addressing** | Retains public IP on PaaS service | Allocates a **dedicated private IP inside your subnet** |
| **Exposure** | PaaS firewall allows specific subnets, but endpoint is still public | **Public access can be completely set to `Disabled`** |
| **On-Premises Access** | ❌ **Cannot** be accessed from on-premises over ExpressRoute or VPN | ✅ **Fully accessible** from on-premises over ExpressRoute / VPN |
| **Peered VNets** | ❌ Cannot be used across peered VNets without NAT/NVA appliances | ✅ **Natively reachable** across any peered VNet |
| **Data Exfiltration** | Subnet can potentially talk to *any* storage account unless Service Endpoint Policies are applied | Traffic is strictly bound to the **specific provisioned resource instance** |
| **Compliance** | Partially satisfies compliance | Standard requirement for **PCI-DSS, HIPAA, FedRAMP, ISO 27001** |

---

## 4. Verification & Testing Commands

### Verify from inside the Workload VM:
```bash
# 1. Verify DNS Resolution returns the Private Endpoint IP
nslookup distorage654321.blob.core.windows.net

# Expected Output:
# Server:    168.63.129.16
# Address:   168.63.129.16#53
#
# Non-authoritative answer:
# distorage654321.blob.core.windows.net  canonical name = distorage654321.privatelink.blob.core.windows.net.
# Name:      distorage654321.privatelink.blob.core.windows.net
# Address:   10.124.0.4

# 2. Test Blob Storage endpoint connectivity
curl -I https://distorage654321.blob.core.windows.net
```

---

## 💡 Key Architectural Takeaways

1. **DNS CNAME Chain:** Azure automatically creates a CNAME for public endpoints pointing to `*.privatelink.blob.core.windows.net`. When a Private DNS Zone is linked, Azure's internal resolver intercepts this and provides the private IP.
2. **Zero Trust Ready:** Private Endpoints allow organizations to set `publicNetworkAccess = "Disabled"`, making cloud PaaS services invisible to port scanners and internet-based threat actors.
3. **Hub-and-Spoke Synergy:** Centralizing Private Endpoints and Private DNS Zones in a Shared Services / Hub VNet enables all spoke VNets to consume secure storage and database endpoints efficiently.

