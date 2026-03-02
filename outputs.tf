# outputs.tf — Output Values

# Security Group
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_server.id
}

# S3 Bucket
output "s3_bucket_name" {
  description = "Name of the S3 backup bucket"
  value       = aws_s3_bucket.backups.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 backup bucket"
  value       = aws_s3_bucket.backups.arn
}

# EC2 Instance (new)
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh ubuntu@${aws_instance.web_server.public_ip}"
}

output "api_url" {
  description = "URL to access the FastAPI app"
  value       = "http://${aws_instance.web_server.public_ip}:8000"
}