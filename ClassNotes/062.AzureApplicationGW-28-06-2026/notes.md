# 🚀 Azure Application Gateway: Multi-Site Routing & SSL Architecture

> **Session Context:** End-to-end multi-site routing lab, custom DNS integration, HTTP vs HTTPS security, and SSL encryption/decryption mechanisms.
> **Reference File:** `diagram.pdf`

---

## 1. Multi-Site Hosting Architecture Lab

```
VNet: vnet-devops (10.0.0.0/16)
+---------------------------------------------------------------------------------+
| Subnets:                                                                        |
| 1. NetflixSubnet (10.0.1.0/24)  -> netflixvm01, netflixvm02 (Backend Pool 1)   |
| 2. StarbucksSubnet (10.0.2.0/24)-> starbucksvm01, starbucksvm02 (Backend Pool 2)|
| 3. ApplicationGatewaySubnet (10.0.3.0/24) -> Azure Application Gateway          |
| 4. AzureBastionSubnet (10.0.4.0/26)      -> Azure Bastion Host                 |
+---------------------------------------------------------------------------------+
```

---

## 2. Application Gateway Routing Configuration

### DNS Setup (A Records):
* `netflix.devopsinsiders.com` $\to$ Application Gateway Public IP (`54.56.54.21`)
* `starbucks.devopsinsiders.com` $\to$ Application Gateway Public IP (`54.56.54.21`)

### Routing Rules & Multi-Site Listeners:
1. **Listener 1 (Netflix):**
   * Host name: `netflix.devopsinsiders.com`
   * Port: 80 / 443
   * Target Backend: **Pool 1** (Netflix VMs)
2. **Listener 2 (Starbucks):**
   * Host name: `starbucks.devopsinsiders.com`
   * Port: 80 / 443
   * Target Backend: **Pool 2** (Starbucks VMs)

---

## 3. SSL / TLS Deep Dive: HTTP vs. HTTPS

```
HTTP (Plain Text):
Client ------------ "P@ssword@1" ------------> Server
         ^
         | Eavesdropping Hacker can read plaintext credentials!

HTTPS (Encrypted with SSL/TLS):
Client ------------ "asdfasdfwer123242" -------> Server
         ^
         | Hacker only sees scrambled ciphertext!
```

### SSL Offloading / Termination:
* The client establishes an encrypted TLS session with the Application Gateway.
* The Application Gateway decrypts the traffic at the perimeter and inspects it via WAF.
* Traffic sent from Application Gateway to internal VMs in the private VNet can run over unencrypted HTTP (Port 80), offloading CPU cryptographic load from backend servers.
