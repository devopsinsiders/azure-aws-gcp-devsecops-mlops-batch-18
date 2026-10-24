# ⚡ Pipeline Parallelism & Directed Acyclic Graph (DAG) Execution

> **Session Context:** Optimizing pipeline execution runtimes using parallelism, Directed Acyclic Graph (`dependsOn: []`) fan-outs, and conditional matrix jobs.
> **Reference File:** `diagram.pdf`

---

## 1. Sequential Execution vs. Parallel Fan-Out

```
Traditional Sequential Pipeline (Total Runtime: 9 Minutes):
[ Scan (2 min) ] ---> [ Validate (5 min) ] ---> [ Plan (2 min) ] ---> Total = 9 mins!

Optimized Parallel Pipeline (Total Runtime: ~5 Minutes):
                      +---> [ Scan Job (2 min) ] -----+
                      |                               |
Trigger ------------->+                               +---> [ Plan Job (2 min) ]
                      |                               |
                      +---> [ Validate Job (5 min) ] -+
```

---

## 2. YAML Syntax for Parallel Execution

By default, stages and jobs execute sequentially unless specified otherwise. To run jobs or stages in parallel, declare empty or shared dependencies:

```yaml
stages:
  - stage: Scan
    jobs:
      - job: tfsec_scan
        dependsOn: []       # Runs immediately in parallel
      - job: tflint_scan
        dependsOn: []       # Runs immediately in parallel
      - job: checkov_scan
        dependsOn: []       # Runs immediately in parallel

  - stage: Plan
    dependsOn: Scan         # Waits for ALL parallel scan jobs to complete
    jobs:
      - job: tf_plan
```

### Benefits of Parallelism:
* Drastically slashes developer wait times during Pull Request checks.
* Enables horizontal scaling across multiple self-hosted pipeline agents.
