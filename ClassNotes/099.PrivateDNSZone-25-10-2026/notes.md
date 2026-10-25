# 🌐 Azure Private DNS Zone & DNS Architecture Deep Dive

> **Session Context:** Understanding Public DNS vs. Private DNS Zones, complete Recursive DNS resolution workflow, and implementing internal name resolution for enterprise workloads (Benefits Portal on Azure Virtual Desktop / VNet).  
> **Reference Diagram:** [`diagram.pdf`](file:///c:/DevOpsInsiders/Batch18/azure-aws-gcp-devsecops-mlops-batch-18/ClassNotes/099.PrivateDNSZone-25-10-2026/diagram.pdf)

---

## 📌 Mindset & Classroom Note
> *"Agar survive krna hai toh ordinary nahi, extra-ordinary learner banna padega. Consistent learning is painful, but mandatory!"*  
> Focus on active study groups (Siksha Sathi), cut down external noise, and build solid hands-on architectural clarity.

---

## 1. DNS Resolution Fundamentals & Client Resolution Hierarchy

Before any query leaves a machine, the operating system follows a strict order to resolve hostnames:

```
                  +-----------------------------------+
                  |        Application Query          |
                  |     (e.g., ping / curl / web)     |
                  +-----------------+-----------------+
                                    |
                                    v
                  +-----------------------------------+
                  | 1. Local Hosts File               |
                  |    - Linux: /etc/hosts            |
                  |    - Windows: hosts file          |
                  +-----------------+-----------------+
                                    | (If not found)
                                    v
                  +-----------------------------------+
                  | 2. Local DNS Resolver Cache       |
                  |    - OS cached entries / nscd     |
                  +-----------------+-----------------+
                                    | (If not found)
                                    v
                  +-----------------------------------+
                  | 3. DNS Client / Configured        |
                  |    Recursive Resolver (168.63.129.16|
                  |    or 8.8.8.8 / ISP DNS)          |
                  +-----------------------------------+
```

### The Recursive DNS Resolution Journey (Illustrated from Diagram)
When resolving an external domain like `dhondhu.com` or `google.com`:

```
 [ Client Machine ]
        |
        | 1. "dhondhu.com ka IP kya hai?"
        v
 [ 4. Recursive DNS Server ] <---> [ Cache Memory ] (Returns immediately if cached)
        |
        | 2. "Bro, .com TLD ko kaun manage karta hai?"
        v
 [ Root DNS Server ( . ) ]
        |
        | Returns: TLD Server referral (e.g., a.gtld.com)
        v
 [ TLD DNS Server (.com) ]
        |
        | 3. "dhondhu.com ka authoritative manager kaun hai?"
        | Returns: Authoritative Name Server (e.g., Cloudflare Name Server)
        v
 [ Authoritative DNS Server (Cloudflare) ]
        |
        | 4. "Bhai mere ko IP bata de bhai!"
        | Returns: A Record (e.g., 45.45.56.54)
        v
 [ Recursive DNS Server ] ---> Caches IP ---> Returns 45.45.56.54 to Client
```

---

## 2. Public DNS Zone: External Internet Access

A **Public DNS Zone** hosts DNS records for domain names resolvable by anyone across the public internet.

### Architecture in Diagram:
* **Domain Registration:** Purchased custom domain `veltrixrockets.space` from a registrar.
* **Name Server Delegation:** Registrar NS records pointed to public DNS zone servers.
* **DNS Records Configured:**
  * `veltrixrockets.space` $\rightarrow$ `45.56.54.56`
  * `dhondhu.veltrixrockets.space` $\rightarrow$ `45.56.54.86`
  * `dashboard.veltrixrockets.space` $\rightarrow$ `54.56.21.45`

```
  [ Internet Users ]
          |
          | Browse: https://dashboard.veltrixrockets.space
          v
  [ Public DNS Resolver ]
          |
          | Resolves to Public IP: 54.56.21.45
          v
  [ Public Web Server / Ingress ] (54.56.21.45)
```

> ⚠️ **Limitation:** Public DNS zones are visible globally. If you place internal corporate IP addresses here, you expose your internal topology, and resolving private IPs over public DNS poses security and compliance risks.

---

## 3. Azure Private DNS Zone: Enterprise Internal Resolution

An **Azure Private DNS Zone** provides a reliable, secure DNS service for virtual networks to manage and resolve domain names without needing custom DNS solutions.

### Diagram Scenario Walkthrough:

```
+---------------------------------------------------------------------------------------+
|  Azure Virtual Network (VNet): 10.124.0.0/16                                          |
|                                                                                       |
|   +------------------------------------+    +--------------------------------------+  |
|   | Subnet: benefits-portal subnet     |    | Subnet: Workstations Subnet          |  |
|   |                                    |    | (Azure Virtual Desktop - AVD)        |  |
|   |   +----------------------------+   |    |                                      |  |
|   |   | Nginx Benefits Portal      |   |    |  [Workstation 1]   [Workstation 2]   |  |
|   |   | Private IP: 10.124.0.4     |   |    |  [Workstation 3]                     |  |
|   |   +----------------------------+   |    |                                      |  |
|   +-----------------+------------------+    +------------------+-------------------+  |
|                     ^                                          |                      |
|                     |             Query:                       |                      |
|                     |             portal.veltrixrocket.internal|                      |
|                     |             Resolves to: 10.124.0.4      |                      |
|                     +------------------------------------------+                      |
|                                                ^                                      |
|                                                |                                      |
|                       +------------------------+-------------------------+            |
|                       |  Azure Private DNS Zone:                         |            |
|                       |  Zone: portal.veltrixrocket.internal             |            |
|                       |  A Record: @ / portal -> 10.124.0.4              |            |
|                       |  Virtual Network Link: Linked to 10.124.0.0/16   |            |
|                       +--------------------------------------------------+            |
+---------------------------------------------------------------------------------------+
```

### Key Components:
1. **Virtual Network (VNet):** `10.124.0.0/16` hosting backend workloads and enterprise desktops.
2. **Benefits Portal Subnet:**
   - Runs an internal **Nginx** web server (`10.124.0.4`) hosting sensitive HR/employee benefits data.
   - Has **NO Public IP** assigned (fully private and isolated from internet attacks).
3. **Workstations Subnet (Azure Virtual Desktop):**
   - Employee virtual desktops (Workstation 1, 2, 3) where staff perform daily tasks.
4. **Private DNS Zone (`portal.veltrixrocket.internal`):**
   - Maps `portal.veltrixrocket.internal` to private IP `10.124.0.4`.
   - **VNet Link:** Attached to VNet `10.124.0.0/16`.
   - Workstations seamlessly resolve `portal.veltrixrocket.internal` using Azure's built-in wire server (`168.63.129.16`) to reach `10.124.0.4`.

---

## 4. Public DNS Zone vs. Private DNS Zone (Comparison)

| Feature | Public DNS Zone | Azure Private DNS Zone |
| :--- | :--- | :--- |
| **Visibility** | Public internet (World-wide) | Restricted to linked Azure VNets |
| **Domain Purchase** | Must purchase from registrar (GoDaddy, Namecheap) | No purchase needed (can use `.internal`, `.corp`, custom names) |
| **IP Addresses** | Public IPv4 / IPv6 addresses | Private RFC 1918 IPs (`10.x.x.x`, `172.16.x.x`, `192.168.x.x`) |
| **Resolution Engine** | Public recursive resolvers & root servers | Azure VIP DNS (`168.63.129.16`) |
| **Auto-Registration** | Not supported | Supported (VMs automatically register their hostname to private IP) |
| **Use Case** | Public apps, APIs, websites (`dashboard.veltrixrockets.space`) | Internal portals (`benefits-portal`), databases, private endpoints |

---

## 5. Practical Implementation & Verification Commands

### 1. Verification from Workstation (Inside VNet)
```bash
# Query the internal private domain
nslookup portal.veltrixrocket.internal

# Output expected:
# Server:    168.63.129.16
# Address:   168.63.129.16#53
# Name:      portal.veltrixrocket.internal
# Address:   10.124.0.4

# Test connectivity to the Nginx portal over HTTP
curl -I http://portal.veltrixrocket.internal
```

### 2. Verification of Public Domain from Outside
```bash
# Query public DNS record
nslookup dashboard.veltrixrockets.space 8.8.8.8

# Query using dig
dig +short dashboard.veltrixrockets.space
# Output: 54.56.21.45
```

### 3. Azure CLI Cheat Sheet for Private DNS Zone
```bash
# 1. Create Private DNS Zone
az network private-dns zone create \
  --resource-group rg-benefits-portal \
  --name veltrixrocket.internal

# 2. Link Private DNS Zone to the VNet
az network private-dns link vnet create \
  --resource-group rg-benefits-portal \
  --zone-name veltrixrocket.internal \
  --name vnet-link \
  --virtual-network vnet-workstations \
  --registration-enabled false

# 3. Create A Record for benefits portal
az network private-dns record-set a add-record \
  --resource-group rg-benefits-portal \
  --zone-name veltrixrocket.internal \
  --record-set-name portal \
  --ipv4-address 10.124.0.4
```

---

## 💡 Key Takeaways for DevOps & Cloud Engineers
1. **Never use Public DNS for private backend services:** It leaks network architecture and private topology.
2. **Azure Magic IP (`168.63.129.16`):** Azure default virtual DNS resolver IP inside any VNet that forwards queries to Azure Private DNS Zones.
3. **Split-Brain / Split-Horizon DNS:** Organizations can have the same domain name (e.g. `company.com`) resolve to a public IP outside the company and an internal private IP inside Azure VNets.
4. **Foundation for Azure Private Endpoints:** Private DNS Zones are mandatory when working with Azure Private Link / Private Endpoints (`privatelink.database.windows.net`, `privatelink.blob.core.windows.net`).
