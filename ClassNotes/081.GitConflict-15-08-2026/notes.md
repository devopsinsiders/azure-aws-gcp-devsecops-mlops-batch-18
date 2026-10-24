# ⚔️ Git Merge Conflicts & Engineer Resilience Mindset

> **Session Context:** Resolving git merge conflicts, internal conflict marker mechanics, and building psychological resilience for tech careers.
> **Reference File:** `diagram.pdf`

---

## 1. What Causes a Git Merge Conflict?

A **Merge Conflict** occurs when two branches modify the **exact same line(s) of code** in a file, or one branch deletes a file while another modifies it, and Git cannot automatically determine which version is correct.

```
                  Commit A (main): rg_name = "rg-devops"
                 /
Initial Commit -+
                 \
                  Commit B (feature): rg_name = "rg-mirzapur"
```

---

## 2. Anatomy of Git Conflict Markers

When a conflict occurs during `git merge` or `git pull`, Git injects conflict markers into the file:

```hcl
<<<<<<< HEAD (Current Changes from main)
rg_name = "rg-devops"
=======
rg_name = "rg-mirzapur"
>>>>>>> feature/new-rg (Incoming Changes)
```

### Resolution Steps:
1. Open the conflicted file in VS Code.
2. Discuss with the author of the conflicting commit.
3. Select the intended version: *Accept Current Change*, *Accept Incoming Change*, or combine both.
4. Remove all conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
5. Stage the resolved file: `git add <file>`.
6. Complete the merge commit: `git commit -m "fix: resolved merge conflict in tfvars"`.

---

## 3. The Engineer Resilience Mindset

* **Patience & Process:** Career breakthroughs require sustained effort over months; avoid panic over temporary blockers.
* **Daily Discipline:** Maintain a technical learning diary, teach peers through screen sharing, and record mock interviews to build communication mastery.
