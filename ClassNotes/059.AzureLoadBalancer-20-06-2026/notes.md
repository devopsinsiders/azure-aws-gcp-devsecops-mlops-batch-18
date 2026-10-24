# ⚖️ Azure Load Balancer Architecture, NAT Gateway & Scaling

> **Session Context:** Deep architectural session on Azure Load Balancers, vertical vs horizontal scaling, outbound internet via NAT Gateway, and jump host subnets.
> **Reference File:** `diagram.pdf`

---

## 1. Vertical Scaling vs. Horizontal Scaling

```
       Vertical Scaling (Scale Up)                 Horizontal Scaling (Scale Out)
       +-------------------------+                 +--------------------------------+
       |   Single Virtual Machine|                 | Multiple Identical VMs Behind  |
       |                         |                 | a Load Balancer                |
       |  2 CPU / 2 GB RAM       |                 |                                |
       |           |             |                 |   [VM 1]   [VM 2]   [VM 3]     |
       |           v             |                 |   (2 CPU)  (2 CPU)  (2 CPU)    |
       |  4 CPU / 4 GB RAM       |                 |     ^        ^        ^        |
       |           |             |                 |     +--------+--------+        |
       |           v             |                 |              |                 |
       |  Physical Hardware Limit|                 |      [Azure Load Balancer]     |
       +-------------------------+                 +--------------------------------+
```

### Why Horizontal Scaling Wins in Cloud:
* **Vertical Scaling:** Hits physical limits, requires VM downtime/reboot, and remains a single point of failure.
* **Horizontal Scaling:** Adds identical VMs behind a Load Balancer; offers unlimited elasticity and high availability without downtime.

---

## 2. Complete Load Balancer Network Topology

```
+---------------------------------------------------------------------------------+
|                         Virtual Network (10.0.0.0/16)                           |
|                                                                                 |
|  +---------------------------+                 +-----------------------------+  |
|  | Netflix Subnet            |                 | Jump VM Subnet              |  |
|  | (10.0.0.0/24)             |                 | (10.0.1.0/24)               |  |
|  |                           |                 |                             |  |
|  | [netflix-vm-01: 10.0.0.4] |                 | [jump-vm: 10.0.1.4]         |  |
|  | [netflix-vm-02: 10.0.0.5] |                 | Public IP: 20.204.1.32      |  |
|  | (Private IPs Only)        |                 | (SSH Bastion / Management)  |  |
|  +-------------^-------------+                 +--------------^--------------+  |
|                |                                              |                 |
|                | Inbound Port 80                              | SSH (Port 22)   |
|        +-------+-------+                                      |                 |
|        | Azure Public  |                                      |                 |
|        | Load Balancer |                                 DevOps Engineer        |
|        | (89.54.56.33) |                                                        |
|        +-------^-------+                                                        |
+----------------|----------------------------------------------------------------+
                 | HTTP Requests
            End Users
```

---

## 3. Outbound Internet for Private VMs: Azure NAT Gateway

* **Problem:** Production VMs in the `Netflix Subnet` do not have Public IPs for security reasons. However, running `sudo apt update && sudo apt install nginx` fails because the VMs cannot reach external package repositories.
* **Solution (Azure NAT Gateway):**
  * Deploy an **Azure NAT Gateway** with a dedicated Public IP.
  * Associate the NAT Gateway directly with the `Netflix Subnet`.
  * All outbound internet traffic from private VMs routes through the NAT Gateway using Source Network Address Translation (SNAT).
  * Inbound connections from the internet remain strictly blocked!

---

## 4. Layer 4 Routing Characteristics

* Azure Load Balancer routes traffic based strictly on **IP 5-tuple**: (Source IP, Source Port, Destination IP, Destination Port, Protocol).
* It does **NOT** inspect HTTP headers, cookie affinity, URL paths (`/api` vs `/static`), or SSL certificates.
