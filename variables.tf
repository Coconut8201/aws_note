variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

variable "project_name" {
  description = "專案名稱"
  type        = string
}

variable "environment" {
  description = "環境 (dev/staging/prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH Key Pair 名稱"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "允許 SSH 連線的 IP 範圍"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
