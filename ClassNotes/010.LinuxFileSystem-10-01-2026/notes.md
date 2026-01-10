# 📘 Linux & Computer Fundamentals – Comprehensive Notes

## 1️⃣ Success ke 4 Stambh (Foundational Mindset)

Success sirf tools se nahi aata, **mindset se aata hai**.

1. **Anushashan (Discipline)**

   * Roz padhna, roz practice
   * Time ka respect

2. **Consistency**

   * Thoda thoda roz
   * Gap aaya to flow toot jaata hai

3. **Mehnat (Hard Work)**

   * Shortcut ka koi shortcut nahi hota

4. **Mind Control (Patience)**

   * Results late milte hain
   * Jaldi haar = failure

👉 *“Karm Hi Pooja Hai”* 🙏

---

## 2️⃣ Application Architecture (Recap)

### 1-Tier Application

* Application **Windows machine par directly deploy**
* Example:

  * Code + Middleware + OS same machine par

### Components:

1. **Computer**
2. **Middleware**
3. **Code (Application)**

---

## 3️⃣ Operating Systems Overview

### Common Operating Systems

* **Windows**
* **Linux**
* **MacOS**

### Access Types

* **GUI (Graphical User Interface)**
  → Mouse, Icons, Right Click
* **CLI (Command Line Interface)**
  → Terminal, Commands (Linux ka asli power 💪)

---

## 4️⃣ Linux Introduction

### Linux kya hai?

* **Open Source**
* Free
* Powerful
* Puri duniya ke **mast log Linux ko dhua-dhua kar dete hain** 😄

### Linux Core

* **Linux Kernel** = Brain of Linux

### Popular Linux Distributions

* Ubuntu
* Kali Linux
* Alpine Linux

---

## 5️⃣ Editors & Basic Commands

### Nano Editor

* `Ctrl + S` → Save
* `Ctrl + X` → Exit

---

## 6️⃣ File & Folder Operations (Linux vs Windows)

### GUI vs CLI Comparison

| Action                  | Windows (GUI)        | Linux (CLI)     |
| ----------------------- | -------------------- | --------------- |
| Delete File             | Right Click → Delete | `rm file`       |
| Delete Folder           | Right Click → Delete | `rm -rf folder` |
| Search                  | Ctrl + F             | `grep`          |
| Case Insensitive Search | Ctrl + F             | `grep -i`       |

---

## 7️⃣ Linux File System – Deep Understanding

### Root of Linux

* `/` → **Sabse upar**
* Isse kehte hain **Root Directory**

### Important Linux Directories

| Directory | Purpose                            |
| --------- | ---------------------------------- |
| `/bin`    | Basic user commands                |
| `/sbin`   | Admin commands                     |
| `/boot`   | Boot ke time lagne wali files      |
| `/etc`    | Configuration files                |
| `/home`   | Users ke folders                   |
| `/lib`    | Libraries                          |
| `/media`  | Pendrive / external disk mount     |
| `/mnt`    | Temporary mount                    |
| `/opt`    | External software                  |
| `/root`   | Root (Administrator) ka home       |
| `/var`    | Logs                               |
| `/tmp`    | Temporary files (situationship 😄) |

---

## 8️⃣ Windows File System (Comparison)

### Windows Structure

* `C:\`
* `D:\`

### Common Windows Folders

* Program Files → Installed Software
* Users → Individual user data
* Boot, Fonts → System related files

Example:

```
Users
 ├── husband
 ├── biwi
```

Har user ka apna **kachra (data)** 😄

---

## 9️⃣ File System Concept

### File System kya hota hai?

> **Hard disk par data ko acche tarike se rakhne ka system**

### Linux Rule:

> **Everything is a file in Linux**

---

## 🔟 File Characteristics (Gun)

File ke sath hum kya kar sakte hain:

* Rename
* Delete
* Read content
* Copy

### Common Commands

* `ls` → list files
* `cp` → copy
* `rm` → delete
* `grep` → pattern search

---

## 1️⃣1️⃣ Users & Permissions

### Root User

* Linux ka **Administrator**
* Folder: `/root`

### Normal Users

* Located in `/home`

```
/home/ramu
/home/rinki
```

---

## 1️⃣2️⃣ Mounting Storage

### External Devices

* Pendrive, Hard Disk

### Mount Locations

* `/media`
* `/mnt`

Example:

* `H:/` (Windows pendrive)
* Linux me `/media/pendrive`

---

## 1️⃣3️⃣ Navigation Commands (Very Important 🔥)

### Special Symbols

* `.` → Current directory
* `..` → One level up
* `/` → Root

### Examples

#### Go back:

```bash
cd ..
```

#### Multiple levels:

```bash
cd ../../../rinki
```

#### Absolute Path

```bash
cd /home/rinki
```

#### Relative Path

```bash
cd home
```

👉 **Absolute Path hamesha `/` se start hota hai**
👉 **Relative Path current location se**

---

## 1️⃣4️⃣ Golden Rules of `cd`

* Jaha user hai wahi se command start hogi
* `/` = root
* Absolute path is safer
* Relative path is faster
