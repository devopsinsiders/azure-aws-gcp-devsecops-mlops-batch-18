# 🌐 How the Internet & Networking Work: CIDR, Subnets & IP Routing

> **Session Context:** Deep dive into networking fundamentals, router functions, private vs public IP addressing, CIDR notation mathematics, and Azure Virtual Network sizing.
> **Reference File:** `diagram.pdf`

---

## 1. What is a Network & Why Do We Need Routers?

A network connects two or more computing devices so they can exchange data.

```
       +-----------------------+
       |     D-Link Router     |
       +-----------+-----------+
                   |
         +---------+---------+
         |                   |
+--------v--------+ +--------v--------+
|   Computer A    | |   Computer B    |
|   (IIS Server)  | |  (Netflix App)  |
|   192.168.0.5   | |   192.168.0.8   |
+-----------------+ +-----------------+
```

### Primary Responsibilities of a Router:
1. **Assign Unique IP Addresses:** Uses DHCP to allocate non-conflicting IP addresses from a pre-configured pool (e.g., `192.168.0.1` to `192.168.0.250`).
2. **Enable Device Communication:** Acts as the default gateway to route packets between internal hosts and out to external networks.

---

## 2. Address Space & CIDR Notation

### What is CIDR?
**CIDR (Classless Inter-Domain Routing)** is a compact mathematical representation of an IP address range.

$$\text{CIDR Format: } \text{First IP Address} / n \quad (n \in [0, 32])$$

* An IPv4 address consists of **32 bits** (4 octets of 8 bits each).
* The number $n$ after the slash denotes the **network prefix bits** (fixed bits).
* The remaining $(32 - n)$ bits are **host bits** available for device addressing.

### The Power-of-2 Sizing Formula:
$$\text{Total IP Addresses} = 2^{(32 - n)}$$

---

## 3. CIDR Calculation Reference Table

| CIDR Prefix | Subnet Mask | Calculation ($2^{32-n}$) | Total IP Count | Primary Cloud Use Case |
| :--- | :--- | :--- | :--- | :--- |
| **/32** | 255.255.255.255 | $2^0$ | **1 IP** | Single Host / Specific Firewall Rule |
| **/29** | 255.255.255.248 | $2^3$ | **8 IPs** | Small service subnets (Azure GatewaySubnet) |
| **/26** | 255.255.255.192 | $2^6$ | **64 IPs** | `AzureBastionSubnet`, Application Gateway |
| **/24** | 255.255.255.0 | $2^8$ | **256 IPs** | Standard Workload Subnet (Frontend / Backend) |
| **/16** | 255.255.0.0 | $2^{16}$ | **65,536 IPs** | Standard Enterprise Azure Virtual Network (VNet) |
| **/10** | 255.192.0.0 | $2^{22}$ | **4,194,304 IPs** | Massive Global Cloud WAN / ISP backbone |
| **/8** | 255.0.0.0 | $2^{24}$ | **16,777,216 IPs** | Very Large Class A Private Network (`10.0.0.0/8`) |

### Key Takeaway on Sizing:
* **Higher Prefix Number ($/24, /26, /32$):** Smaller network, fewer host IPs.
* **Lower Prefix Number ($/16, /10, /8$):** Larger network, millions of host IPs.

---

## 4. Azure Networking Reservations

> ⚠️ **Important Azure Rule:** In any Azure Subnet, **Azure reserves 5 IP addresses** for internal routing and services:
* `.0`: Network address.
* `.1`: Default Gateway.
* `.2` & `.3`: Azure DNS mapping.
* `.255`: Broadcast address.
* *Usable IPs in an Azure `/24` subnet:* $256 - 5 = 251$ usable IPs.

---

## 5. Homework & Practical Exercise

1. Calculate the total IP address count for `192.0.0.0/16`.
2. Determine the CIDR notation required to host **400,000 IP addresses**.
3. Determine the CIDR notation required to host **1,200,000 IP addresses**.
