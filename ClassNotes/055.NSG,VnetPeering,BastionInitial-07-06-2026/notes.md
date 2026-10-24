# 🛡️ NSG, VNet Peering & Azure Bastion Fundamentals

> **Session Context:** Network security modeling, Network Security Group (NSG) port filtering, security risks of Public IPs, and the introduction of Azure Bastion.
> **Reference File:** `diagram.pdf`

---

## 1. Network Security Groups (NSG): The Cloud Firewall

An **NSG** contains security rules that allow or deny inbound and outbound network traffic to Azure resources (NICs or Subnets).

### House Analogy:
Think of an IP address as a house address, and ports as specific rooms:
* Port 1: Drawing Room
* Port 2: Kitchen
* Port 3: Bedroom
* Port 4: Office
* **Port 22:** SSH Server (Linux)
* **Port 80:** HTTP Web Server (Nginx / Apache)
* **Port 443:** HTTPS Web Server
* **Port 3389:** RDP Server (Windows)

> 🔒 **Default NSG Behavior:** For security, all inbound ports from the Internet are closed by default. You must explicitly configure allow rules.

---

## 2. Inbound vs Outbound Rule Evaluation

```
Internet Request ---> [ NSG Priority Check: 100 to 4096 ] ---> VM Port
                      (Lower number evaluated first)
```

* Rules are processed in priority order (lowest number first, e.g., 100 before 200).
* Once a match is found, subsequent rules are not evaluated.
* To allow web traffic: create an inbound rule for Port 80 with Priority 100.
* To allow SSH management: create an inbound rule for Port 22 with Priority 110.

---

## 3. The Security Danger of Public IPs on VMs

When each VM has a Public IP:
1. Vulnerable to continuous port scanning, automated brute-force attacks, and DDoS.
2. Management ports (22, 3389) exposed to the public internet are prime targets.
3. Using a simple Jump VM with a Public IP creates a **Single Point of Failure (SPOF)**. If that single VM is breached, the attacker gains network access to all internal VMs!

---

## 4. Introduction to Azure Bastion

**Azure Bastion** is a fully managed Platform-as-a-Service (PaaS) offering that provides secure and seamless RDP and SSH connectivity directly through the Azure Portal over TLS (Port 443).

```
                      Azure Portal (Browser)
                               |
                               | HTTPS / Port 443
                               v
                     +--------------------+
                     |   Azure Bastion    |
                     | (Dedicated Subnet) |
                     +---------+----------+
                               |
              +----------------+----------------+
              | Private SSH (22)                | Private RDP (3389)
              v                                 v
    +--------------------+            +--------------------+
    |      Linux VM      |            |     Windows VM     |
    | (Private IP Only)  |            | (Private IP Only)  |
    +--------------------+            +--------------------+
```

### Key Bastion Advantages:
* **Zero Public IPs on Workload VMs:** Compute VMs remain 100% private.
* **No Agent Required:** Runs natively inside the web browser via HTML5.
* **Protection Against Port Scanning:** Since management ports are not exposed externally, port scanning is completely mitigated.
