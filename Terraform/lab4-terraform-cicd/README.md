This project demonstrates how to implement a production-style CI/CD pipeline for Terraform using GitHub Actions.

Instead of manually running infrastructure changes, this repository automates:

- Terraform plan validation on pull requests
- Automated terraform apply on merge to main
- Manual destroy workflows with approval gates
- Security scanning using Checkov
- Scheduled drift detection
- Environment-specific deployments (staging & production)
- Artifact storage and infrastructure output tracking

This lab simulates real-world Infrastructure-as-Code workflows used in DevOps teams.

---

# Architecture Overview

The repository follows a structured layout:

```
terraform-cicd-lab/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tf
│
├── .github/workflows/
│   ├── terraform-plan.yml
│   ├── terraform-apply.yml
│   ├── terraform-destroy.yml
│   ├── terraform-staging.yml
│   ├── security-scan.yml
│   └── drift-detection.yml
│
├── scripts/
└── README.md
```

---

# CI/CD Strategy

## 1️ Pull Request Workflow (Plan Stage)

When a pull request targets `main`:

- Terraform formatting check runs
- Configuration validation executes
- Terraform plan is generated
- Plan output is posted as a PR comment
- Workflow fails if validation fails

This ensures infrastructure changes are reviewed before deployment.

---

## 2️ Merge to Main (Apply Stage)

On successful merge to `main`:

- Terraform initializes
- Plan is generated
- Changes are applied automatically
- Outputs are exported as artifacts
- Generated infrastructure files are archived

This enforces consistent, automated deployments.

---

## 3️ Manual Destroy Workflow

Destroy operations require:

- Manual trigger via workflow_dispatch
- Explicit confirmation input
- Full plan before destroy
- Controlled execution

This prevents accidental infrastructure deletion.

---

## 4️ Environment-Based Deployment

A separate staging workflow deploys when pushing to the `develop` branch.

This demonstrates:

- Environment isolation
- Branch-based deployments
- Controlled promotion strategy

---

## 5️ Security Scanning

Infrastructure code is scanned automatically using Checkov.

This provides:

- Misconfiguration detection
- Policy validation
- Compliance visibility
- SARIF reporting integration

Security checks run on:

- Pull requests
- Direct pushes to main

---

## 6️ Drift Detection

A scheduled workflow runs weekly to detect configuration drift.

If drift is detected:

- Terraform plan runs with detailed exit codes
- A GitHub issue is automatically created
- Full drift details are attached

This simulates real production governance practices.

---

# Infrastructure Design

The Terraform configuration includes:

- Random resource suffix generation
- Multiple dynamically generated files
- JSON summary output
- YAML configuration file creation
- Structured outputs
- Variable-driven resource counts
- Environment tagging logic

Although it uses local resources, the pipeline design is production-ready.

---

# DevOps Skills Demonstrated

- Infrastructure as Code automation
- CI/CD workflow engineering
- GitHub Actions pipeline design
- Plan vs Apply separation
- Automated PR commenting
- Artifact management
- Secure workflow permissions
- Drift monitoring strategy
- Branch-based deployment models
- Terraform backend configuration
- Automated compliance scanning

---

# Production-Level Practices Implemented

- No direct auto-apply on PR
- Explicit approval workflow for destructive operations
- Validation before execution
- Artifact retention strategy
- Security scan integration
- Environment promotion strategy
- Automated infrastructure reporting
- Scheduled governance checks

---

# Why This Project Matters

Modern DevOps teams require:

- Automated infrastructure pipelines
- Safe deployment workflows
- Audit trails for infrastructure changes
- Security integration within CI/CD
- Drift detection and governance controls

This lab demonstrates the ability to design and implement those systems.
