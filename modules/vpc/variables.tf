variable "project_name" {
  description = "專案名稱"
  type        = string
}

variable "environment" {
  description = "環境 (dev/staging/prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.0.0/20"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR block"
  type        = string
  default     = "10.0.16.0/20"
}

variable "availability_zone-a" {
  description = "Availability Zone A"
  type        = string
}

variable "availability_zone-c" {
  description = "Availability Zone C"
  type        = string
}
