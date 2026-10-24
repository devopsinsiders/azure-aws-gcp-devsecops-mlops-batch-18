# 🌐 Azure Application Gateway & Layer 7 Load Balancing

> **Session Context:** Limitations of Layer 4 Load Balancers, introduction to Application Gateway (Layer 7), Path-Based routing, SSL termination, and WAF integration.
> **Reference File:** `diagram.pdf`

---

## 1. Limitations of Azure Load Balancer (Layer 4)

Why does an enterprise outgrow a standard Layer 4 Load Balancer?
* ❌ **No Path-Based Routing:** Cannot inspect URL paths (e.g., cannot route `/admin` and `/payments` to different VM pools).
* ❌ **No SSL Termination:** Cannot decrypt HTTPS traffic; backend VMs must handle CPU-intensive cryptographic handshakes.
* ❌ **No Web Application Firewall (WAF):** Cannot protect against OWASP Top 10 vulnerabilities, SQL injection, or cross-site scripting (XSS).
* ❌ **Multiple Public IPs Required:** Hosting multiple websites requires multiple Public IPs.
* ❌ **No Cookie-Based Affinity:** Cannot bind a user session to a specific backend server.

---

## 2. Application Gateway (Layer 7) Features

```
                         Internet Request: HTTPS
                                    |
                                    v
                     +------------------------------+
                     |  Azure Application Gateway   |
                     |  - Layer 7 Application Proxy |
                     |  - WAF (OWASP Detection)     |
                     |  - SSL Offloading / Term     |
                     |  - Cookie-Based Affinity     |
                     +--------------+---------------+
                                    |
             +----------------------+----------------------+
             | Path: /order                                | Path: /payments
+------------v------------+                   +------------v------------+
|     Backend Pool 1      |                   |     Backend Pool 2      |
|    (Order Services)     |                   |   (Payment Services)    |
+-------------------------+                   +-------------------------+
```

---

## 3. Regional vs. Global Traffic Distribution

| Scope | Layer 4 (Transport) | Layer 7 (Application) |
| :--- | :--- | :--- |
| **Regional (Single Region)** | **Azure Load Balancer** | **Azure Application Gateway** |
| **Global (Multi-Region)** | **Azure Traffic Manager** (DNS-based) | **Azure Front Door** (Anycast + CDN + WAF) |

---

## 4. Multi-Site Hosting Scenario: StreamFlix & Starbucks

```
                    Users accessing:
    streamflix.b18g0.online   OR   starbucks.b18g0.online
                     \             /
                      \           /
               +-------v---------v-------+
               |   Single Public IP      |
               |  (20.120.27.183:80/443) |
               +------------+------------+
                            |
             +--------------v---------------+
             |  Azure Application Gateway   |
             |  (ApplicationGatewaySubnet)  |
             +--------------+---------------+
                            |
         +------------------+------------------+
         | Host: streamflix...                 | Host: starbucks...
+--------v--------+                   +--------v--------+
|  Netflix Subnet |                   | Starbucks Subnet|
| [ubuntu-vm1]    |                   | [ubuntu-vm3]    |
| [ubuntu-vm2]    |                   | [ubuntu-vm4]    |
+-----------------+                   +-----------------+
```

### Key Takeaway:
Using Application Gateway Host-Based Routing, **multiple domain names share a single Public IP**, drastically simplifying DNS management and slashing cloud IP costs!
