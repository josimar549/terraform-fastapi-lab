# outputs.tf — Output Values

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_server.id
}

output "s3_bucket_name" {
  description = "Name of the S3 backup bucket"
  value       = aws_s3_bucket.backups.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 backup bucket"
  value       = aws_s3_bucket.backups.arn
}

output "connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh ubuntu@${aws_instance.web_server.public_ip}"
}

output "api_url" {
  description = "URL to access the API (once deployed)"
  value       = "http://${aws_instance.web_server.public_ip}:8000"
}
