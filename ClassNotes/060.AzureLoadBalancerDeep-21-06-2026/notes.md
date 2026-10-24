# 🛠️ Azure Load Balancer Deep Dive & Practical Hands-on

> **Session Context:** Step-by-step implementation of an Azure Load Balancer, multi-frontend IP configurations, backend pools, health probes, and custom load balancing rules.
> **Reference File:** `diagram.pdf`

---

## 1. Network Blueprint for Hands-on Lab

```
Virtual Network: vnet-dhondhu (10.124.0.0/16)
Location: Central India
+---------------------------------------------------------------------------------+
| 1. Frontend Subnet: 10.124.0.0/24                                               |
|    - frontend-vm-01 (Private IP) -> Runs Nginx ("Frontend 1")                  |
|    - frontend-vm-02 (Private IP) -> Runs Nginx ("Frontend 2")                  |
|    - Attached to NAT Gateway for outbound package installation                  |
|                                                                                 |
| 2. AzureBastionSubnet: 10.124.1.0/26                                            |
|    - Azure Bastion PaaS (or Jump VM) for secure administration                  |
+---------------------------------------------------------------------------------+
```

---

## 2. Step-by-Step Implementation Sequence

1. **Virtual Network & Subnets:** Create `vnet-dhondhu` (`10.124.0.0/16`) with `Frontend-subnet` (`/24`) and `AzureBastionSubnet` (`/26`).
2. **Deploy Private Workload VMs:** Deploy `frontend-vm-01` and `frontend-vm-02` with **Private IPs only** in the frontend subnet.
3. **Outbound Internet via NAT Gateway:** Create an Azure NAT Gateway with a Public IP and attach it to `Frontend-subnet` to allow `apt install nginx`.
4. **Deploy Jump Host / Bastion:** Connect into the private VMs via SSH to configure custom Nginx landing pages.
5. **Create Azure Load Balancer:**
   * **SKU:** Standard (Production-grade, zone-redundant).
   * **Type:** Public.
6. **Configure Frontend IP:** Assign a static Public IP (e.g., `4.247.242.69`).
7. **Configure Backend Pool:** Add the NICs of `frontend-vm-01` and `frontend-vm-02`.
8. **Configure Health Probe:**
   * **Name:** `nginx-check`
   * **Protocol:** HTTP
   * **Port:** 80
   * **Path:** `/`
   * **Interval:** 5 seconds, Unhealthy threshold: 2 consecutive failures.
9. **Configure Load Balancing Rule:**
   * **Frontend Port:** 8090 (or 22222)
   * **Backend Port:** 80
   * **Session Persistence:** None (Round-Robin).
10. **Validation:** Hit `http://4.247.242.69:8090/` from multiple browser sessions and verify alternating responses between Frontend 1 and Frontend 2.

---

## 3. Advanced Multi-Frontend IP Configurations

A single Azure Load Balancer can host multiple Frontend Public IPs mapping to different backend pools:

```
+---------------------------------------------------------+
|                  Azure Load Balancer                    |
|                                                         |
|  Frontend IPs:                                          |
|  - IP-Config-1: 56.54.56.87                             |
|  - IP-Config-2: 54.56.54.89                             |
|  - IP-Config-3: 89.54.65.23                             |
|                                                         |
|  Backend Pool: frontend-vm-pool (VM1, VM2, VM3, VM4)    |
|                                                         |
|  Rules:                                                 |
|  - IP-Config-1:Port 80   --> frontend-vm-pool:80        |
|  - IP-Config-2:Port 8080 --> frontend-vm-pool:8080      |
+---------------------------------------------------------+
```
