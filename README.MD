# DevOps Assignment — Node.js Backend + Docker + Terraform + Jenkins + Trivy

## Project Overview
This project demonstrates core DevOps practices by building and containerizing a simple **Node.js backend**, running it locally using **Docker**, provisioning cloud infrastructure on **AWS** using **Terraform**, and validating infrastructure security using a **Jenkins CI pipeline** with **Trivy IaC scanning**.

The overall goal is to show a **secure-by-default** approach to cloud deployments:

1. Containerize a backend web application using Docker.
2. Run the application locally to prove the container works.
3. Provision AWS infrastructure using Terraform with an intentional misconfiguration (for learning/demo).
4. Detect Terraform misconfigurations using Trivy in a Jenkins pipeline (before deployment).
5. Use AI to interpret the Trivy report and create a remediated (“secure”) Terraform version.
6. Re-run the pipeline until the Terraform scan reports **zero critical issues**.

## Architecture (Current Scope: Backend + Local Docker)
### Application
- **Backend:** Node.js API (containerized)
- **Container Port:** `3000`
- **Runtime:** Docker container built from `backend/Dockerfile`

### Local Container Run (Dockerfile-based)

1. Build the Docker image locally:
   ```bash
    cd backend
    docker build -t phone-api-backend:local .
   ```
2. Run the Docker container:
   ```bash
   docker run -p 127.0.0.1:3000:3000 phone-api-backend:local

   Access the API at: http://localhost:3000/api/phones
   ```

## Docker Build, image and Run Output

<img width="1900" height="492" alt="docker1png" src="https://github.com/user-attachments/assets/55d14496-952b-4813-9690-5904d957da75" />

<img width="1890" height="580" alt="imagedocker" src="https://github.com/user-attachments/assets/e09f4d8a-af15-40a1-9a7f-2cc2738ba2a1" />

<img width="1918" height="1006" alt="jsonData" src="https://github.com/user-attachments/assets/1ed8c2a6-0b9b-412b-9684-b8c98b3a577d" />

# Stop container
```bash 
    docker stop phone-api-backend-local
    docker rm phone-api-backend-local


