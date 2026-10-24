# 🌐 Domain Name System (DNS) Internals & Recursive Name Resolution

> **Session Context:** End-to-end DNS architecture, recursive resolvers, root name servers, TLD servers, authoritative servers, and preparing for Private DNS Zones.
> **Reference File:** `diagram.pdf`

---

## 1. What is DNS & Why is it Critical for Cloud?

**DNS (Domain Name System)** translates human-readable hostnames (`netflix.devopsinsiders.com`) into computer-routable IP addresses (`104.211.89.46`).

---

## 2. Step-by-Step Recursive Resolution Walkthrough

```
[ User Browser ]
       |
       | 1. Query: "netflix.devopsinsiders.com"
       v
[ Recursive DNS Resolver (e.g. 1.1.1.1 / 8.8.8.8) ]
       |
       | 2. "Who manages .com?"
       v
[ Root Name Server (13 logical servers: a.root-servers.net ...) ]
       |
       | Returns: ".com TLD Name Servers"
       v
[ TLD Name Server (g.gtld-servers.net) ]
       |
       | 3. "Who manages devopsinsiders.com?"
       | Returns: Authoritative Cloudflare / GoDaddy Name Servers
       v
[ Authoritative Name Server (elinore.ns.cloudflare.com) ]
       |
       | 4. Looks up A Record for "netflix.devopsinsiders.com"
       | Returns: 104.211.89.46
       v
[ Recursive Resolver caches IP and delivers to User Browser ]
       |
       v
[ Browser connects directly to Web Server on 104.211.89.46:80/443 ]
```

---

## 3. Core DNS Record Types in Cloud Engineering

* **A Record (Address):** Maps a hostname directly to an IPv4 address (`api.axion.com -> 54.12.21.56`).
* **CNAME Record (Canonical Name):** Maps an alias hostname to another hostname (`diarchitectwa.blob.core.windows.net -> blob.core.windows.net`).
* **NS Record (Name Server):** Delegates a DNS zone to authoritative servers.
* **Troubleshooting DNS:** Use `nslookup` or `dig` to verify records:
  ```bash
  nslookup netflix.devopsinsiders.com 8.8.8.8
  ```
