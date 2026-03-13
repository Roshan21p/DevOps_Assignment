# DevOps Assignment — Node.js Backend + Docker + Terraform + Jenkins + Trivy

## Project Overview
This project is submitted as part of the DevOps assignment. It implements a simple **Node.js backend** containerized with **Docker**, provisioned on **AWS** using **Terraform**, deployed on an **EC2 instance**, and prepared for infrastructure security validation through a **Jenkins CI pipeline** using **Trivy**.

The complete assignment workflow includes:

1. Building a Node.js backend application
2. Containerizing the application using Docker
3. Running the application locally using Docker and Docker Compose
4. Creating AWS infrastructure using Terraform
5. Using an IAM user for Terraform authentication
6. Configuring an EC2 security group for SSH and application access
7. Introducing an intentional Terraform misconfiguration for security scanning
8. Connecting to the EC2 instance and installing Docker and Git
9. Deploying the backend application on AWS EC2
10. Creating a Jenkins pipeline for automation
11. Running Trivy to detect Terraform misconfigurations
12. Using AI to analyze the Trivy report and suggest remediation
13. Re-running the pipeline after remediation until no critical or high issues remain

---

## Architecture

### 1. Application
- **Backend:** Node.js API
- **Container Port:** `3000`
- **Exposed Port:** `3000`
- **Application Directory:** `backend/`
- **Runtime:** Docker container

### 2. Deployment Flow
- The backend application is built and tested locally
- Docker is used to containerize the application
- Docker Compose is used for local orchestration
- Terraform provisions the AWS infrastructure
- An EC2 instance is created and accessed using SSH
- Docker and Git are installed on the EC2 instance
- The application is deployed on EC2 using Docker
- Jenkins is used to automate infrastructure validation
- Trivy scans Terraform code for security misconfigurations
- AI is used to understand findings and support remediation

---

## Local Docker Run

### Build the Docker image
```bash
cd backend
docker build -t phone-api-backend:local .
```

### Run the Docker container
```bash
docker run -p 127.0.0.1:3000:3000 phone-api-backend:local
```

### Access the API
`http://localhost:3000/api/phones`

---

## Docker Build and Run Output

<img width="1900" height="492" alt="docker1png" src="https://github.com/user-attachments/assets/55d14496-952b-4813-9690-5904d957da75" />

<img width="1890" height="580" alt="imagedocker" src="https://github.com/user-attachments/assets/e09f4d8a-af15-40a1-9a7f-2cc2738ba2a1" />

<img width="1918" height="1006" alt="jsonData" src="https://github.com/user-attachments/assets/1ed8c2a6-0b9b-412b-9684-b8c98b3a577d" />

---

## Run Using Docker Compose

### Start the application
```bash
docker compose up --build
```

### Access the API
`http://localhost:3000/api/phones`

---

## Docker Compose Output

<img width="1916" height="807" alt="dockerCompose" src="https://github.com/user-attachments/assets/4a656422-adc7-4075-b555-a419530d0dbb" />

<img width="1918" height="948" alt="jsonCompose" src="https://github.com/user-attachments/assets/48ab5b61-ec3e-4c9a-a59e-e712614b1175" />

---

## Cloud Infrastructure (AWS + Terraform)

To allow Terraform to create and manage AWS resources, an IAM user was used.

### IAM User
- **IAM User Name:** `terraform-user`

<img width="1595" height="177" alt="IAMUSer" src="https://github.com/user-attachments/assets/ce809294-6319-42a6-a2bf-f86682a28c1b" />


### Purpose
This IAM user provides programmatic access to AWS so Terraform can authenticate and provision infrastructure resources.

### Resources Managed by Terraform
- EC2 instance
- Security group
- Required networking configuration

### Security Note
The IAM user is used only for infrastructure provisioning and is separate from EC2 login access through the AWS key pair file.

---

## Terraform on AWS

Terraform is used to provision the AWS infrastructure required for this project.

### Terraform Commands
```bash
# 1. Initialize Terraform
cd terraform
terraform init

# 2. Format Terraform files
terraform fmt

# 3. Validate Terraform configuration
terraform validate

# 4. Review planned changes
terraform plan

# 5. Create or update AWS infrastructure
terraform apply
```

### Terraform Output
After applying the Terraform configuration, the EC2 instance was created successfully.

- **Instance Public IP:** `13.201.75.251`

---

## Security Group Configuration

A security group is attached to the EC2 instance to control traffic.

### Current Inbound Rules
- **SSH (Port 22):** enabled for EC2 remote access
- **Application Port (3000):** enabled so the Node.js backend can be accessed publicly

### Intentional Misconfiguration
As required in the assignment, the Terraform configuration contains an intentional security misconfiguration.

The SSH rule allows access from anywhere:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

### Why It Was Added
This insecure rule is intentionally kept so that it can be detected by **Trivy** in the Jenkins pipeline and later remediated.

---

## Terraform Execution Output
<img width="1018" height="683" alt="terraformInit" src="https://github.com/user-attachments/assets/0fb97a63-8522-4689-9aa3-90b8ad8788f1" />

<img width="1362" height="856" alt="terraform2" src="https://github.com/user-attachments/assets/d9bdfc17-a42f-4296-8b25-ff13fdb72e78" />

<img width="1588" height="748" alt="ec2Instance" src="https://github.com/user-attachments/assets/e8abf969-9620-425f-8d9a-4ae3cbfb90d2" />

---

## AWS EC2 Deployment

After the EC2 instance was created, the backend application was deployed on the server.

### SSH into EC2
```bash
ssh -i "your-key.pem" ubuntu@13.201.75.251
```

### Install Docker and Git
```bash
sudo apt update
sudo apt install -y docker.io git
sudo systemctl enable docker
sudo systemctl start docker
```

### Verify Installation
```bash
docker --version
git --version
```

### Clone the Repository
```bash
git clone https://github.com/Roshan21p/DevOps_Assignment.git
cd DevOps_Assignment/backend
```

### Build the Docker Image on EC2
```bash
sudo docker build -t phone-api-backend .
```

### Run the Container on EC2
```bash
sudo docker run -d --name phone-api-container -p 3000:3000 phone-api-backend
```

### Public API URL
`http://13.201.75.251:3000/api/phones`

---

## AWS Deployment Output

<img width="1915" height="691" alt="DockerComposeEC2" src="https://github.com/user-attachments/assets/5638fdf9-5ece-422d-8759-19e8cf397e21" />


<img width="1132" height="74" alt="dockerEC2Expose" src="https://github.com/user-attachments/assets/c72cc836-9926-47d2-9e6e-1e0b66c388d0" />


<img width="1915" height="977" alt="jsonEc2" src="https://github.com/user-attachments/assets/bce5518d-d2fa-4d64-b7c9-6124f22651a6" />

---

## Repository
GitHub repository:

`https://github.com/Roshan21p/DevOps_Assignment`

---

## Author
**GitHub Username:** `Roshan21p`