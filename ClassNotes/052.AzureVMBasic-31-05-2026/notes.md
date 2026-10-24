# 🖥️ Azure Virtual Machine Basics & Network Architecture

> **Session Context:** Core session on Azure Virtual Machines, NIC binding, multi-subnet VNet routing, availability options, and fault domain redundancy.
> **Reference File:** `diagram.pdf`

---

## 1. Anatomy of an Azure Virtual Machine

A physical computer and a cloud virtual machine share the same architectural building blocks:

```
+--------------------------------------------------------+
|                    Azure Virtual Machine               |
|                                                        |
|  +----------------+  +----------------+  +----------+  |
|  |      CPU       |  |      RAM       |  | OS Disk  |  |
|  | (e.g. 16 Core) |  | (e.g. 19 Core) |  | (1TB SSD)|  |
|  +----------------+  +----------------+  +----------+  |
|                           |                            |
|             +-------------v-------------+              |
|             | Network Interface (NIC)   |              |
|             +-------------+-------------+              |
+---------------------------|----------------------------+
                            | Plugged into
             +--------------v---------------+
             |     Azure VNet Subnet        |
             +------------------------------+
```

### Key Rule:
> *"VM ek khali dabba hota hai uspe NIC connect karna padta hai. Bina NIC ka VM duniya se disconnected hota hai."*
> (A Virtual Machine is pure compute. It cannot communicate with anything until a Network Interface Card is attached to it and plugged into a Subnet).

---

## 2. VNet Subnet Communication Rules

Consider a Virtual Network `10.0.0.0/16` deployed in Central India:

```
+---------------------------------------------------------------+
|             Virtual Network (10.0.0.0/16) - Central India     |
|                                                               |
|  +---------------------------+  +--------------------------+  |
|  | Frontend Subnet           |  | Backend Subnet           |  |
|  | 10.0.1.0/24               |  | 10.0.2.0/24              |  |
|  |                           |  |                          |  |
|  | [VM 1: 10.0.1.2]          |  | [VM 2: 10.0.2.4]         |  |
|  | Public IP: 56.54.56.98    |  | (Private IP only)        |  |
|  +-------------+-------------+  +-------------+------------+  |
|                |                              |               |
|                +---- Default Azure Routing ---+               |
|                      (Private Communication)                  |
+---------------------------------------------------------------+
```

### Golden Rules of Azure VNet Connectivity:
1. **Intra-VNet Communication:** VMs in different subnets of the **SAME Virtual Network** can talk to each other by default without any gateway or peering!
2. **Inter-VNet Communication:** VMs in **DIFFERENT Virtual Networks** CANNOT communicate unless **VNet Peering** is explicitly configured.

---

## 3. High Availability & Resilience Options

A single VM has no disaster recovery or SLA guarantee if an underlying rack or hardware fails. Azure provides two primary availability models:

```
Azure Region: Central India
+-----------------------------------------------------------------+
|  Availability Zones (Physically separate datacenters)           |
|                                                                 |
|  +------------------+  +------------------+  +----------------+ |
|  |      Zone 1      |  |      Zone 2      |  |     Zone 3     | |
|  |   [ VM - Web 1 ] |  |   [ VM - Web 2 ] |  |  [ VM - Web 3] | |
|  +------------------+  +------------------+  +----------------+ |
+-----------------------------------------------------------------+
```

### 1. Availability Zones (AZ)
* Physically separate datacenters within the same Azure region.
* Each zone has independent power, cooling, and networking.
* Distributing VMs across Zone 1, Zone 2, and Zone 3 provides protection against entire datacenter outages.

### 2. Availability Sets (AS)
* Logical grouping of VMs within the same datacenter.
* Separates VMs across:
  * **Fault Domains (FD):** Separate power sources and physical network switches.
  * **Update Domains (UD):** Separate reboot sequences during Azure maintenance.
