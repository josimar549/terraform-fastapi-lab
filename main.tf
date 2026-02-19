# main.tf — AWS Infrastructure with Terraform
#
# Provisions a simple web server environment on AWS free tier:
# - EC2 instance (t2.micro)
# - Security group (SSH + HTTP)
# - S3 bucket for backups

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ── Provider Configuration ─────────────────────────────────────────────────────
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "terraform-aws-lab"
      ManagedBy   = "Terraform"
      Environment = var.environment
      Owner       = "josimar549"
    }
  }
}

# ── Data Sources ───────────────────────────────────────────────────────────────
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {}
data "aws_vpc" "default" {
  default = true
}

# ── Security Group ─────────────────────────────────────────────────────────────
resource "aws_security_group" "web_server" {
  name        = "${var.project_name}-sg"
  description = "Security group for web server - SSH and HTTP access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom app port"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-security-group"
  }
}

# ── EC2 Instance ───────────────────────────────────────────────────────────────
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = "devops-lab-key"

  vpc_security_group_ids = [aws_security_group.web_server.id]

  user_data = <<-EOF
              #!/bin/bash
              set -e
              apt-get update
              apt-get upgrade -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              mkdir -p /opt/app
              echo "Server is running!" > /var/www/html/index.html
              echo "Setup complete" > /var/log/user-data.log
              EOF

  tags = {
    Name = "${var.project_name}-instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ── S3 Bucket for Backups ──────────────────────────────────────────────────────
resource "aws_s3_bucket" "backups" {
  bucket = "${var.project_name}-backups-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-backups"
  }
}

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "backups" {
  bucket = aws_s3_bucket.backups.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ── S3 Lifecycle (fixed warning) ───────────────────────────────────────────────
resource "aws_s3_bucket_lifecycle_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    id     = "delete-old-backups"
    status = "Enabled"

    filter {
      prefix = ""  # Required to fix warning
    }

    expiration {
      days = 30
    }
  }
}
