This lab focuses on implementing production-grade Docker security controls.

The objective is to reduce container attack surface, enforce runtime restrictions, and apply defense-in-depth principles using native Docker security mechanisms.

This lab simulates real-world container hardening practices used in secure production environments.

---

## Security Areas Covered

### 1️ User Namespace Isolation
- Configured Docker daemon with `userns-remap`
- Prevented containers from running as real root on the host
- Verified UID/GID remapping behavior

### 2️ Seccomp System Call Filtering
- Created custom restrictive seccomp profile
- Blocked dangerous syscalls (e.g., mount)
- Tested syscall enforcement behavior

### 3️ AppArmor Mandatory Access Control
- Created and loaded custom AppArmor profile
- Restricted capabilities (e.g., sys_admin)
- Enforced mount and privilege restrictions

### 4️ Vulnerability Scanning (Docker Scout)
- Scanned official images (nginx, node)
- Compared vulnerable vs hardened images
- Generated remediation recommendations

### 5️ Container Resource Limits
- Applied memory constraints
- Applied CPU limits and shares
- Enforced PID limits
- Used ulimits
- Verified enforcement with docker stats

### 6️ Runtime Hardening
- Enforced non-root user execution
- Dropped Linux capabilities
- Enabled read-only root filesystem
- Mounted secure tmpfs
- Used `no-new-privileges`

---

## Skills Demonstrated

- Docker daemon configuration
- Linux namespace isolation
- Seccomp profile authoring
- AppArmor policy creation
- Image vulnerability analysis
- Resource governance
- Runtime container hardening
- Defense-in-depth implementation
