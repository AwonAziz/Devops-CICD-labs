The objective was not just to write Terraform code, but to deeply understand:

- HCL syntax and structure
- Variables, locals, and outputs
- Iteration mechanisms (`for_each`, `count`)
- Dynamic configuration blocks
- Code validation and formatting
- Infrastructure-as-Code (IaC) best practices

All infrastructure examples use the `local` provider to safely simulate resource provisioning.

---

# Environment Setup

The lab was performed on a clean Linux machine with Terraform installed manually.

## Install Terraform (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository \
"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update
sudo apt install terraform
```

Verify installation:

```bash
terraform version
```

---

# Project Structure

```
hcl-fundamentals-lab/
│
├── examples/
│   ├── variables/
│   ├── advanced/
│   └── basic-syntax.tf
│
└── complete-example/
```

---

# 1️ HCL Syntax & Validation

Created a simple Terraform configuration to understand:

- Blocks
- Arguments
- Expressions
- Lists and maps
- Variable types

Validation & formatting:

```bash
terraform init
terraform validate
terraform fmt
```

---

# 2️ Variables, Locals, and Outputs

## Variables

- Primitive types (string, number, bool)
- Complex types (list, map, object)
- Validation blocks
- Default values
- terraform.tfvars overrides

## Locals

Used locals for:

- Derived values
- Conditional logic
- Computed storage totals
- Tag merging
- Map/list manipulation

## Outputs

- Simple outputs
- Computed outputs
- Conditional outputs
- Sensitive outputs
- JSON-formatted output

Tested using:

```bash
terraform plan
terraform apply -auto-approve
terraform output
terraform output -json server_configurations
```

---

# 3️ Advanced HCL Features

## for_each

Used to dynamically generate:

- User configuration files
- Environment-specific configs
- Developer access policies

## count

Implemented:

- Conditional resource creation
- Indexed naming
- Iterative server definitions

## Dynamic Blocks & Complex Expressions

Used:

- List comprehensions
- Conditional expressions
- Template rendering
- JSON encoding
- YAML encoding
- Nested loops
- Flattened data structures

---

# 4️ Complete Infrastructure Simulation

Built a full modular configuration that includes:

- Multi-region deployments
- Service-based iteration
- Random ID generation
- Password generation
- Regional configuration mapping
- Monitoring config generation
- Kubernetes manifest templates
- Deployment scripts

This demonstrates real-world Infrastructure-as-Code patterns.

---

# HCL Best Practices Applied

- Meaningful variable descriptions
- Validation blocks
- Clear naming conventions
- Separation of concerns
- Use of locals for computed logic
- Minimal repetition (DRY principle)
- Sensitive outputs handling
- Structured file hierarchy

---

# Key Technical Skills Demonstrated

- Advanced HCL expressions
- Map & list comprehensions
- Terraform functions (merge, concat, timestamp, jsonencode, yamlencode)
- Iteration patterns (for_each, count)
- Templatefile usage
- Infrastructure modeling without cloud dependencies
- IaC maintainability principles
