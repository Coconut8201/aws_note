variable "project_name" {
  description = "專案名稱"
  type        = string
}

variable "environment" {
  description = "環境 (dev/staging/prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}