# ⚖️ Azure Load Balancing Fundamentals & Career Strategy

> **Session Context:** Introduction to Azure Load Balancing, Layer 4 traffic distribution, JMeter load generation, and DevSecOps interview preparation.
> **Reference File:** `diagram.pdf`

---

## 1. What is Azure Load Balancer?

Azure Load Balancer operates at **Layer 4** (Transport Layer) of the OSI model. It routes incoming traffic based on network packet attributes: **Source IP, Source Port, Destination IP, Destination Port, and Protocol (TCP/UDP)**.

```
                    Internet Users / Traffic
                               |
                               v
                     +--------------------+
                     | Azure Public IP    |
                     | (40.80.89.178:80)  |
                     +---------+----------+
                               |
                     +---------v----------+
                     | Azure Load Balancer|  (Layer 4 Round-Robin Distribution)
                     +----+----------+----+
                          |          |
         +----------------+          +----------------+
         |                                            |
+--------v--------+                          +--------v--------+
|  Backend VM 1   |                          |  Backend VM 2   |
| (10.0.0.4:80)   |                          | (10.0.0.5:80)   |
+-----------------+                          +-----------------+
```

---

## 2. The Four Pillars of Any Load Balancer

Every load balancing system in the world (Azure, AWS, GCP, Nginx, F5) is built on four core components:

1. **Frontend IP Configuration:** The public or private IP address that receives incoming client requests.
2. **Backend Pool:** The group of target Virtual Machines (or VM Scale Sets) that serve the application traffic.
3. **Health Probe:** Continuously monitors backend instances (e.g., HTTP probe on port 80 or TCP probe) to ensure traffic is only routed to healthy VMs.
4. **Load Balancing Rules:** Maps the Frontend IP & port to the Backend Pool & port (e.g., route Frontend Port 80 to Backend Port 80 using Round-Robin).

---

## 3. Load Testing with Apache JMeter

* **Why Load Test?** To validate how the infrastructure behaves under peak user concurrency.
* **JMeter Setup:** Configure Thread Groups to simulate hundreds or thousands of simultaneous virtual users hitting the Public IP (`40.80.89.178`).
* Observe how the Azure Load Balancer distributes requests across VM 1 and VM 2 without dropping connections.

---

## 4. DevSecOps Career & Interview Blueprint

The whiteboard lays down actionable career guidance:

### Profile & Resume Optimization:
* **Positioning:** Target roles as **Senior DevSecOps Consultant** (e.g., 7–8 years equivalent expertise).
* **LinkedIn Presence:** Maintain a professional profile, post 3 high-quality technical posts weekly, and set status to *Open to Work*.
* **Naukri.com Strategy:** Upload your updated PDF resume **twice a day from your mobile app** to maintain 100% profile freshness in recruiter search algorithms.
* **Immediate Joiner Status:** Mark as immediate joiner / serving notice to maximize recruiter call frequency.

### The 13 Interview Talking Points:
1. Two-minute crisp self-introduction.
2. Problem statement and client business use case.
3. High-Level Design (HLD) walkthrough.
4. Low-Level Design (LLD) details.
5. Team capacity and agile role.
6. Terraform Parent & Child module architecture.
7. Git branching: Trunk-Based Development, Branch Policies, PR reviews.
8. CI/CD pipelines: Azure DevOps & GitHub Actions.
9. Pipeline Agents: Self-hosted vs Microsoft-hosted runners.
10. Agent Pools and Service Connections (Workload Identity Federation).
11. Parallel jobs and dependency mapping (`dependsOn`).
12. Reusable pipeline templates and variable groups.
13. Production troubleshooting and failure mitigation strategies.
