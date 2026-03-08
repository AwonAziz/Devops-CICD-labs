This lab demonstrates how to extend Prometheus monitoring with **Thanos** to enable long-term metrics storage, high availability, and unified querying.

A complete monitoring stack was built using Prometheus, Thanos components, and MinIO object storage.

## Technologies Used
- Prometheus
- Thanos
- MinIO (S3-compatible storage)
- Node Exporter
- Linux / Systemd
- Docker

## Architecture
The lab deploys the following monitoring components:

Prometheus → collects metrics  
Node Exporter → system metrics source  
Thanos Sidecar → uploads metrics blocks  
MinIO → object storage backend  
Thanos Store Gateway → access historical metrics  
Thanos Query → unified querying interface  
Thanos Compactor → data optimization

## Key Features Implemented
- Prometheus metrics collection
- Object storage for long-term metrics
- Thanos Sidecar integration
- Historical data querying via Thanos Query
- Store Gateway for object storage access
- Compactor for data optimization

## Verification Steps
Key validation checks performed:

- Confirm all services are running
- Verify ports are listening
- Ensure metrics upload to object storage
- Test queries via Thanos Query API
- Generate load to produce historical metrics

Example test query:

```bash
curl http://localhost:10904/api/v1/query?query=up
Web Interfaces
Service	Port
Prometheus	9090
Thanos Query	10904
Thanos Sidecar	10902
Thanos Store	10906
Thanos Compactor	10907
MinIO Console	9001
Skills Demonstrated

Monitoring infrastructure deployment

Prometheus configuration

Distributed metrics architecture

Object storage integration

Linux service management
