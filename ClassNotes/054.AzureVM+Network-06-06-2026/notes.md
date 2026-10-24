# 🌐 Azure VM, Virtual Networking & Traffic Flow Deep Dive

> **Session Context:** Practical implementation of multi-VNet, multi-subnet VM topologies, region rules, logical components, and step-by-step traffic inspection.
> **Reference File:** `diagram.pdf`

---

## 1. Regional Dependencies & Architectural Rules

* **Resource Group vs Resources:** A Resource Group (RG) is purely a logical metadata container. A Resource Group can reside in `centralindia`, while the resources inside it (VNet, VM, Storage) can reside in `eastus` or `westeurope`.
* **VNet vs VM Rule:** A Virtual Machine **MUST** be deployed in the **exact same region** as the Virtual Network and Subnet to which its NIC is connected!

---

## 2. The Complete Anatomy of an Azure VM

Creating a VM requires multiple distinct Azure resource types:

```
Azure VM Infrastructure Stack:
+--------------------------------------------------------------+
| 1. Resource Group: Logical boundary                          |
| 2. Virtual Network & Subnets: IP address space               |
| 3. Network Interface (NIC): Attaches VM to Subnet            |
| 4. IP Addresses: Private IP (Mandatory) + Public IP (Optional)|
| 5. Storage: OS Managed Disk & Data Disks                     |
| 6. Compute Engine: Size, Cores, RAM, Image (Windows/Ubuntu)  |
| 7. Security: Network Security Group (NSG) with Port Rules    |
+--------------------------------------------------------------+
```

---

## 3. Practical Multi-VNet Hands-on Lab

```
                   +----------------------------------+
                   |          Resource Group          |
                   +-----------------+----------------+
                                     |
         +---------------------------+---------------------------+
         |                                                       |
+--------v-----------------------+      +------------------------v-------+
|  VNet 1 (10.56.0.0/16)         |      |  VNet 2 (10.57.0.0/16)         |
|  Location: Central India       |      |  Location: Central India       |
|                                |      |                                |
|  Frontend Subnet (10.56.1.0/24)|      |  App Subnet (10.57.1.0/24)     |
|  [ Linux VM (chinmay-vm) ]     |      |  [ Windows VM ]                |
|  Private: 10.56.1.4            |      |  Private: 10.57.1.4            |
|  Public:  104.211.89.161       |      |  Public:  20.219.32.137        |
|                                |      |                                |
|  Backend Subnet (10.56.2.0/24) |      +--------------------------------+
|  [ Backend VM ]                |
+--------------------------------+
```

### Lab Observations:
1. VMs inside `VNet 1` (even in different subnets) communicate seamlessly via Azure's default system route.
2. VMs between `VNet 1` and `VNet 2` cannot communicate until **VNet Peering** is established between them.

---

## 4. End-to-End Hands-on Traffic Walkthrough

### The Challenge Scenario:
How do you access a private Linux VM securely using a Windows Jump VM?

1. Open Remote Desktop Connection (**RDP**) on your local laptop.
2. Connect to the Windows VM using its Public IP on **Port 3389** (Requires NSG rule permitting 3389 inbound).
3. Inside the Windows VM desktop, open **PowerShell**.
4. Run SSH from the Windows VM to the Linux VM using its **Private IP**:
   ```powershell
   ssh devopsadmin@10.56.1.4
   ```
5. Install Nginx web server on the Linux VM:
   ```bash
   sudo apt update && sudo apt install -y nginx
   ```
6. Access the Linux VM's web page from your browser over HTTP (**Port 80**).

---

## 5. Packet Routing Breakdown

| Communication Scenario | Routing Mechanism |
| :--- | :--- |
| **Same Subnet** | Direct L2/L3 delivery via Azure Virtual Network SDN. No hops. |
| **Different Subnet (Same VNet)** | Traffic flows via Azure Default System Gateway (`10.56.1.1` / `10.56.2.1`). No manual routing needed. |
| **Different VNet** | Traffic crosses the Microsoft Private Backbone via **VNet Peering** (0 internet hops). |
| **Public Internet** | Hits Azure Load Balancer / Public IP, passes NSG evaluation, and translates via NAT to VM's private IP. |
