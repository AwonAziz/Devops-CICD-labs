This lab focuses on deploying a **multi-tier web application stack using Ansible automation**.  
The goal was to understand how modern applications are structured and how configuration management tools can automate the deployment of multiple components.

The environment was configured to deploy a **three-tier architecture**, consisting of:

- Web server (Nginx)
- Application backend (Python/Flask)
- Database server (MySQL)

Each component was deployed using **Ansible roles** to ensure modular, reusable automation.

---

## Key Concepts Practiced

- Multi-tier application architecture
- Infrastructure automation using Ansible
- Role-based automation structure
- Database provisioning and configuration
- Web server configuration with Nginx
- Backend application deployment with Python
- Service management using systemd

---

## Technologies Used

- Ansible
- Python / Flask
- MySQL
- Nginx
- YAML
- Linux
- systemd

---

## Application Architecture

The application follows a **three-tier model**:
Client Browser
│
▼
Web Server (Nginx)
│
▼
Application Server (Flask API)
│
▼
Database (MySQL)


Each tier performs a different function:

- **Web Tier** – Serves frontend and routes requests
- **Application Tier** – Handles API logic
- **Database Tier** – Stores application data

---

## Project Structure


multi-tier-app/
├── roles/
│ ├── database/
│ ├── webserver/
│ └── application/
├── group_vars/
├── templates/
├── files/
├── inventory.ini
└── ansible.cfg


Roles were used to separate responsibilities:

- `database` → installs and configures MySQL  
- `webserver` → configures Nginx reverse proxy  
- `application` → deploys the Flask backend and frontend

---

## Deployment Process

1. Prepare the Linux environment and install Ansible
2. Configure the Ansible inventory for localhost testing
3. Build the multi-tier project directory structure
4. Create Ansible roles for database, web server, and application
5. Deploy the full application stack using playbooks
6. Verify the application by accessing the web interface

---

## Example Verification

After deployment, the application can be accessed via:


http://localhost


API endpoints are accessible through:


http://localhost/api/tasks


---

## What I Learned

This lab demonstrated how **automation tools can deploy complex application stacks consistently and reliably**.

Key takeaways:

- Roles make Ansible projects modular and maintainable
- Multi-tier architecture separates responsibilities between services
- Automation simplifies deployment of full application stacks
- Infrastructure and applications can be deployed together using configuration management tools
