# Dhua Dhua Revision Class – Comprehensive Notes

## 1. IT Everywhere Concept

* Today **Information Technology (IT)** exists in almost every industry.
* Example: **Travel booking platforms** like MakeMyTrip.
* Websites allow users to:

  * Search flights
  * Book hotels
  * Plan travel

Example workflow:

1. User opens the website.
2. Enters travel details (Delhi → Bangalore).
3. System processes request.
4. Results are shown from the database.

This shows how **web applications work behind the scenes**.

---

# 2. Platforms Where Applications Run

Modern applications are accessible on multiple platforms:

1. **Website (Browser)**
2. **Android App**
3. **Apple / iOS App**

All these platforms communicate with the **same backend APIs**.

Example API:

```
api.makemytrip.com/findFlights
```

APIs connect **frontend applications to backend services**.

---

# 3. 3-Tier Architecture (Most Common Web Architecture)

Example analogy: **Restaurant**

| Restaurant | IT System |
| ---------- | --------- |
| Waiter     | Frontend  |
| Kitchen    | Backend   |
| Store Room | Database  |

### 1. Frontend (Presentation Layer)

What users interact with.

Examples of technologies:

* React
* NextJS
* Angular

Responsibilities:

* User interface
* User experience
* Taking inputs
* Showing results

Developed by: **Frontend Developer**

---

### 2. Backend (Application Layer)

Backend processes business logic.

Examples of technologies:

* Python
* Go
* Rust
* Java
* .NET

Responsibilities:

* Processing requests
* Business logic
* Communicating with database
* Returning results to frontend

Developed by: **Backend Developer**

---

### 3. Database (Data Layer)

Stores application data.

Examples:

* MySQL
* MongoDB
* PostgreSQL

Responsibilities:

* Data storage
* Query execution
* Data retrieval

Managed by: **Database Developer / DBA**

---

# 4. Example Logic Execution

Example formula:

a = ?
b = ?

Application calculates:

[
c = a^2 + b^2 + 2ab
]

Steps:

1. User enters values.
2. Backend processes the formula.
3. Result is stored in the database.
4. Result returned to frontend.

---

# 5. Roles in Software Development

## UX Designer

Designs the **user experience** and layout of the application.

Responsibilities:

* UI design
* User flow
* Screen layout

---

## Developers

### Frontend Developer

Creates UI using:

* React
* Angular
* NextJS

### Backend Developer

Creates server-side logic using:

* Python
* Java
* .NET

### Database Developer

Manages:

* Data structure
* Queries
* Performance

---

# 6. Software Architecture

An **Architect** designs the system.

Types of architecture diagrams:

### High Level Diagram (HLD)

Shows:

* Overall system structure
* Major components
* Interaction between services

Example:
Frontend → Backend → Database

---

### Low Level Diagram (LLD)

Contains detailed technical information:

* Server configuration
* Network details
* APIs
* Database schema

---

# 7. Landing Zone in Cloud

In cloud environments, the **architecture diagram is often called a Landing Zone**.

Landing Zone includes:

* Security
* Backup
* Disaster Recovery (DR)
* Governance
* Compliance
* Best Practices

Purpose:
Provide **ready infrastructure where applications can run securely**.

---

# 8. DevSecOps Engineer

A **DevSecOps Engineer**:

* Takes developer code
* Deploys it into the landing zone
* Ensures:

  * Security
  * Automation
  * Monitoring
  * CI/CD

In simple terms:

**Developer writes code → DevSecOps deploys and secures it.**

---

# 9. Business Flow in IT Projects

Typical IT workflow:

Customer → Sales → Architect → Developers → Deployment

### 1. Sales / PreSales

* Talks to client
* Understands requirements
* Prepares proposals

### 2. Manager

* Manages project execution
* Coordinates teams

### 3. Architect

* Designs system architecture
* Creates HLD and LLD

### 4. Developers

* Build application code

### 5. DevOps

* Deploys application

---

# 10. Important Project Documents

## Functional Document

Explains:

* What system should do
* Features
* Functional behavior

---

## Statement of Work (SOW)

Defines:

* Project scope
* Timeline
* Deliverables
* Responsibilities

---

## RACI Matrix

Defines responsibilities:

| Term        | Meaning                             |
| ----------- | ----------------------------------- |
| Responsible | Person doing the work               |
| Accountable | Person responsible for final result |
| Consulted   | Experts consulted                   |
| Informed    | People kept updated                 |

---

# 11. Agile Development Process

Projects are divided into **smaller units called sprints**.

### Sprint

Duration example:

* 21 days

Comparison:

| Time Unit | Duration |
| --------- | -------- |
| Week      | 7 days   |
| Month     | 30 days  |
| Sprint    | ~21 days |

---

# 12. User Stories

Requirements are broken into **user stories**.

Example:

User Story:

> As a user, I want to search flights so that I can book travel.

User stories are further broken into **tasks**.

---

# 13. Tracking Tools

Teams track work using tools like:

* JIRA
* Azure Boards

These tools manage:

* Tasks
* Bugs
* Sprint progress
* Developer assignments

---

# 14. Version Control (GitHub)

Developers push their code to repositories.

Example repository:

```
github.com/devopsinsiders/StreamFlix
```

Benefits:

* Version control
* Collaboration
* Code history
* CI/CD integration

---

# 15. Types of Application Architectures

## 1 Tier Architecture

All components in **one system**.

Frontend + Backend + Database

Example:

* Simple apps
* Streamflix example

Requires:

* Only one computer

---

## 2 Tier Architecture

Structure:

Frontend + Backend
Database

Used in many small systems.

---

## 3 Tier Architecture

Most modern applications.

Structure:

Frontend
Backend
Database

Benefits:

* Scalability
* Security
* Separation of concerns

---

# 16. Deployment

Deployment means:

**Running application code on a server.**

Simple definition:

> Deployment = Code ko computer par run karna.

---

# 17. Where Applications Can Be Deployed

Applications can run on:

### 1. Local Computer

Example:
Windows machine

---

### 2. Linux Environment

Example:

* Local Linux
* Practice platforms

---

### 3. Cloud Platforms

Common cloud providers:

* Microsoft Azure
* AWS
* Google Cloud

---

# 18. Middleware

Middleware connects applications with servers.

Example:

**IIS (Internet Information Services)**

Deployment path example:

```
C:\inetpub\wwwroot
```

Steps:

1. Install IIS
2. Copy application code to:

```
C:\inetpub\wwwroot
```

3. IIS serves the application.

---

# 19. DevOps Workflow

Complete DevOps flow:

1. Customer gives requirement
2. Architect designs system
3. Developers write code
4. Code pushed to GitHub
5. DevOps deploys application
6. Application runs on server/cloud

---

# 20. Key Idea of the Diagram

The diagram explains **how an IT product moves from idea to deployment**:

Customer → Sales → Architect → Developers → GitHub → DevOps → Server → Users
