# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = module.vpc.public_subnet_id
}

# Security Group Outputs
output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}

# EC2 Outputs - Public Instance
output "public_ec2_instance_id" {
  description = "Public EC2 Instance ID"
  value       = module.public-ec2.instance_id
}

output "public_ec2_public_ip" {
  description = "Public EC2 Instance Public IP"
  value       = module.public-ec2.public_ip
}

output "public_ec2_private_ip" {
  description = "Public EC2 Instance Private IP"
  value       = module.public-ec2.private_ip
}

# EC2 Outputs - Private Instance
output "private_ec2_instance_id" {
  description = "Private EC2 Instance ID"
  value       = module.private-ec2.instance_id
}

output "private_ec2_private_ip" {
  description = "Private EC2 Instance Private IP"
  value       = module.private-ec2.private_ip
}

# Access Information
output "ssh_command" {
  description = "SSH command to connect to the public instance"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${module.public-ec2.public_ip}"
}

output "http_url" {
  description = "HTTP URL to access the web server on public instance"
  value       = "http://${module.public-ec2.public_ip}"
}
