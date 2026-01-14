output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.ec2.id
}
