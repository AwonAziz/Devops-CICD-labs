This lab focuses on diagnosing and recovering from Terraform failures.

Instead of building infrastructure from scratch, the goal is to simulate real-world problems such as:

- State corruption
- Broken apply operations
- Configuration errors
- Permission failures
- Drift issues
- Variable validation mistakes

This project demonstrates operational Terraform skills required in production environments.

---

## What This Lab Covers

### 1️ State Management Issues
- Inspecting Terraform state
- Backing up state files
- Removing resources from state
- Importing existing resources
- Refreshing drifted infrastructure

### 2️ Terraform Console Debugging
- Testing variables and expressions
- Validating conditional logic
- Checking loops and data structures
- Verifying template outputs

### 3️ Error Handling & Recovery
- Handling partial apply failures
- Using targeted applies
- Reading debug logs
- Implementing safe retry strategies
- Lock file management

### 4️ Logging & Diagnostics
- Enabling `TF_LOG=DEBUG`
- Analyzing Terraform logs
- Understanding provider errors
- Identifying root causes of failures

---

## Skills Demonstrated

- Terraform state troubleshooting
- Infrastructure recovery techniques
- HCL debugging
- Defensive variable validation
- Log analysis
- Safe deployment practices

---

## Why This Lab Matters

In real DevOps environments, infrastructure breaks.

Knowing how to **recover, debug, and safely fix issues** is just as important as writing Terraform code.

This lab demonstrates production-level troubleshooting ability.
