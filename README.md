# ☁️ Terraform AWS Infrastructure Lab — FastAPI Deployment

![Terraform](https://img.shields.io/badge/terraform-1.0+-blue)
![AWS](https://img.shields.io/badge/AWS-free_tier-orange)
![Docker](https://img.shields.io/badge/docker-container-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-API-green)
![License](https://img.shields.io/badge/license-MIT-green)

End-to-end **Infrastructure as Code (IaC)** project using Terraform to provision AWS resources and deploy a **FastAPI application** in a Docker container.

**100% Free Tier Compatible** — All AWS resources stay within free tier limits.

---

## 🚀 What This Provisions

- **EC2 Instance** — t2.micro or t3.micro Ubuntu server (free tier)  
- **Security Group** — SSH (22), HTTP (80), and App port (8000)  
- **S3 Bucket** — Encrypted storage for backups with versioning and lifecycle policies  
- **Automated Setup** — User data installs Docker, Python, and dependencies  
- **FastAPI App** — Minimal API containerized with Docker, served via Uvicorn  

Example API response:

```json
{"message": "Hello from FastAPI"}
🛠 Prerequisites
AWS Account — Sign up at aws.amazon.com/free

AWS CLI

brew install awscli
aws --version
Configure AWS Credentials

aws configure
AWS Access Key ID

AWS Secret Access Key

Default region: us-east-1

Default output format: json

Install Terraform

brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
Install Docker (local optional)

docker --version
⚡ Quick Start
1. Initialize Terraform
terraform init
2. Preview Changes
terraform plan
3. Apply Infrastructure
terraform apply
Type yes to provision:

EC2 instance with Security Group

S3 bucket with versioning

Output public IP and connection details

4. Connect to EC2
ssh -i ~/Downloads/devops-lab-key.pem ubuntu@<instance_public_ip>
5. Deploy FastAPI App
Option A — Manual
Copy files to EC2 and build Docker container:

scp -i ~/Downloads/devops-lab-key.pem -r ./fastapi-test ubuntu@<instance_public_ip>:~/fastapi-test
ssh -i ~/Downloads/devops-lab-key.pem ubuntu@<instance_public_ip>
cd ~/fastapi-test
sudo docker build -t fastapi-test .
sudo docker run -d -p 8000:8000 fastapi-test
Visit:

http://<instance_public_ip>:8000
Option B — One Command Deployment
Automatically copy, build, and run FastAPI on EC2:

tar -czf fastapi-test.tar.gz ./fastapi-test
scp -i ~/Downloads/devops-lab-key.pem fastapi-test.tar.gz ubuntu@<instance_public_ip>:~/
ssh -i ~/Downloads/devops-lab-key.pem ubuntu@<instance_public_ip> \
"tar -xzf fastapi-test.tar.gz && cd fastapi-test && sudo docker build -t fastapi-test . && sudo docker run -d -p 8000:8000 fastapi-test"
Combines upload, extraction, Docker build, and container run in a single step

FastAPI API is immediately available on port 8000

📂 Project Structure
terraform-aws-lab/
├── main.tf                    # Main infrastructure config
├── variables.tf               # Input variable definitions
├── outputs.tf                 # Output values
├── terraform.tfvars           # Variable values (git-ignored)
├── terraform.tfvars.example   # Example values
├── Dockerfile                 # FastAPI + Docker container
├── main.py                    # FastAPI app
├── README.md
└── .gitignore                 # Ignore state files and secrets
🔐 Security Best Practices
S3 bucket blocks public access

S3 bucket versioning enabled

Security group restricts inbound traffic to specific ports

Default tags applied to all resources

User data script fails fast (set -e)

💡 Next Steps / Enhancements
Automate Docker deployment with Terraform user_data

Add Route53 domain + HTTPS with ACM

Multi-environment support (dev/staging/prod)

CI/CD integration with GitHub Actions

Monitoring with CloudWatch alarms and dashboards

💰 Cost Estimation
Free tier: $0
After free tier (approx): ~$9/month

EC2 t2.micro: ~$8/month

S3 storage (5GB): ~$0.12/month

Data transfer: ~$1/month

Always destroy resources to avoid charges:

terraform destroy
🏆 Skills Demonstrated
Terraform / Infrastructure as Code (IaC)

AWS EC2, S3, Security Groups

Docker containerization

Python FastAPI backend

Public app deployment and networking

Author
Josimar Arias — Software Engineer · Mesa, AZ
josimar85209@gmail.com · GitHub · Portfolio

License
MIT