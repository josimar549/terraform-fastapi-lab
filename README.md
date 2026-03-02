☁️ Terraform AWS + FastAPI Lab

This project demonstrates Infrastructure as Code (IaC) using Terraform to deploy an AWS EC2 instance running a FastAPI app in Docker, along with an S3 bucket for backups.

All resources are AWS Free Tier compatible.

🔹 Features

EC2 Instance — Ubuntu 22.04 server (t2.micro)

Security Group — Allows SSH, HTTP, and FastAPI port 8000

S3 Bucket — Encrypted storage with versioning and 30-day lifecycle

Automated Setup — EC2 installs Docker, Docker Compose, and prepares /opt/app

FastAPI App — Minimal API returning {"message":"Hello from FastAPI"}

🛠️ Prerequisites

AWS Account – Sign up here

Install AWS CLI

# macOS
brew install awscli
aws --version

Configure AWS credentials

aws configure

Install Terraform

# macOS
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
🚀 Quick Start
1. Initialize Terraform
terraform init
2. Preview changes
terraform plan
3. Provision infrastructure
terraform apply

Type yes when prompted. This will:

Create security group

Launch EC2 instance

Create S3 bucket

4. View outputs
terraform output

You’ll get:

EC2 public IP

SSH connection command

S3 bucket name

FastAPI URL

5. Connect to EC2
ssh -i devops-lab-key.pem ubuntu@<instance-public-ip>
docker --version
6. Deploy FastAPI with Docker
# Move into app folder
cd /opt/app

# Build Docker image
sudo docker build -t fastapi-app .

# Run container
sudo docker run -d -p 8000:8000 fastapi-app

Visit in browser: http://<instance-public-ip>:8000 → should show:

{"message":"Hello from FastAPI"}
7. Cleanup

IMPORTANT: Destroy resources when done to avoid charges:

terraform destroy
📂 Project Structure
terraform-fastapi-lab/
├── main.tf                  # Terraform config
├── variables.tf             # Terraform variables
├── outputs.tf               # Terraform outputs
├── terraform.tfvars         # Local variable values (ignored)
├── terraform.tfvars.example # Example variable values
├── Dockerfile               # FastAPI Dockerfile
├── main.py                  # FastAPI app code
├── README.md                # This file
└── .gitignore               # Ignored files
📝 Author

Josimar Arias — Software Engineer · Mesa, AZ
📧 josimar85209@gmail.com
 · GitHub Portfolio

License: MIT
