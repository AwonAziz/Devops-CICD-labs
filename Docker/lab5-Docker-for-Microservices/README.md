This lab demonstrates how to design and deploy a **microservices-based application using Docker containers**.

Multiple independent services are built and containerized, then deployed together using **Docker Compose**. Each service handles a specific responsibility such as user management, product catalog, and order processing.

The architecture also includes an **API Gateway** to route requests and a **frontend interface** for interacting with the system.

---

## Architecture

The application consists of several microservices:

- **User Service** – authentication and user management
- **Product Service** – product catalog and inventory
- **Order Service** – order creation and processing
- **API Gateway** – request routing between services
- **Frontend** – simple interface to test the system

Each service runs in its own **Docker container** and communicates over a shared Docker network.

---

## Key Concepts Practiced

- Microservices architecture design
- Building Docker images for multiple services
- Container networking and service discovery
- API gateway routing
- Inter-service communication via HTTP
- Deploying multi-container applications with Docker Compose
- Basic scaling and fault tolerance testing
- Monitoring service health endpoints

---

## Technologies Used

- Docker
- Docker Compose
- Node.js / Express
- REST APIs
- JSON / HTTP
- Linux CLI

---

## Project Structure

```
microservices-ecommerce/
│
├── services/
│   ├── user-service
│   ├── product-service
│   ├── order-service
│   ├── api-gateway
│   └── frontend
│
├── database/
├── monitoring/
├── shared/
└── logs/
```

---

## Deployment

The services are containerized with Docker and deployed together using **Docker Compose**, allowing them to communicate through a shared internal network.

Once deployed, the system can be tested through the **API Gateway** and the **frontend interface**.

---

## Skills Demonstrated

- Containerized microservices development
- Docker networking and service discovery
- API gateway implementation
- Multi-container orchestration
- Microservices troubleshooting and monitoring
