# ☁️ Terraform AWS Infrastructure Lab

![Terraform](https://img.shields.io/badge/terraform-1.0+-blue)
![AWS](https://img.shields.io/badge/AWS-free_tier-orange)
![License](https://img.shields.io/badge/license-MIT-green)

Infrastructure as Code (IaC) project using Terraform to provision AWS resources. Demonstrates cloud infrastructure management, security best practices, and automated deployments.

**100% Free Tier Compatible** — All resources stay within AWS free tier limits.

---

## What This Provisions

- **EC2 Instance** — t2.micro Ubuntu server (free tier)
- **Security Group** — Firewall rules for SSH, HTTP, and custom app port
- **S3 Bucket** — Encrypted storage for backups with lifecycle policies
- **Automated Setup** — User data script installs Docker and dependencies

---

## Prerequisites

### 1. AWS Account
Sign up at [aws.amazon.com/free](https://aws.amazon.com/free) (12 months free tier)

### 2. Install AWS CLI
```bash
# macOS
brew install awscli

# Verify installation
aws --version
````

### 3. Configure AWS Credentials

```bash
aws configure
```

Enter:

* **AWS Access Key ID**: From AWS Console → IAM → Users → Security Credentials
* **AWS Secret Access Key**: Same place
* **Default region**: `us-east-1`
* **Default output format**: `json`

### 4. Install Terraform

```bash
# macOS
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Verify
terraform version
```

---

## Quick Start

### Step 1: Initialize Terraform

```bash
terraform init
```

### Step 2: Preview Changes

```bash
terraform plan
```

### Step 3: Provision Infrastructure

```bash
terraform apply
```

Type `yes` when prompted. Terraform will:

1. Create security group
2. Launch EC2 instance
3. Create S3 bucket
4. Configure networking

Takes ~2-3 minutes.

### Step 4: View Outputs

```bash
terraform output
```

You’ll see:

* Instance public IP
* SSH connection command
* S3 bucket name
* API URL (once deployed)

### Step 5: Connect to EC2

```bash
# SSH into server (replace with actual IP)
ssh -i ~/Downloads/devops-lab-key.pem ubuntu@<instance-public-ip>

# Check Docker
docker --version
```

---

## Running FastAPI

1. Make sure your `main.py` is in the project folder:

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI"}
```

2. Build and run Docker container:

```bash
sudo docker build -t fastapi-test .
sudo docker run -d -p 8000:8000 fastapi-test
```

3. Access in browser:

```
http://<instance-public-ip>:8000
```

---

## Project Structure

```
terraform-fastapi-lab/
├── main.tf                    # Main infrastructure config
├── variables.tf               # Input variable definitions
├── outputs.tf                 # Output values
├── terraform.tfvars           # Variable values (git-ignored)
├── terraform.tfvars.example   # Example values
├── Dockerfile                 # FastAPI Docker setup
├── main.py                    # FastAPI app code
├── README.md                  # This file
└── .gitignore                 # Ignore state files and secrets
```

---

## Cleanup

**IMPORTANT:** Always destroy resources when done to avoid charges:

```bash
terraform destroy
```

Type `yes` to confirm. This deletes:

* EC2 instance
* Security group
* S3 bucket (and contents)

---

## Author

**Josimar Arias** — Software Engineer · Mesa, AZ
[josimar85209@gmail.com](mailto:josimar85209@gmail.com) · [GitHub](https://github.com/josimar549) · [Portfolio](https://josimar549.github.io)

---

## License

MIT


