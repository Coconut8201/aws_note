variable "project_name" {
  description = "專案名稱"
  type        = string
}

variable "environment" {
  description = "環境 (dev/staging/prod)"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket 名稱後綴"
  type        = string
}

variable "versioning_enabled" {
  description = "是否啟用版本控制"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "是否封鎖公開存取"
  type        = bool
  default     = true
}

# Lifecycle 相關變數
variable "enable_lifecycle_rule" {
  description = "是否啟用生命週期規則"
  type        = bool
  default     = false
}

variable "transition_to_ia_days" {
  description = "轉換到 STANDARD_IA 的天數"
  type        = number
  default     = 30
}

variable "transition_to_glacier_days" {
  description = "轉換到 GLACIER 的天數"
  type        = number
  default     = 90
}

variable "expiration_days" {
  description = "物件過期天數"
  type        = number
  default     = 365
}

# CORS 相關變數
variable "enable_cors" {
  description = "是否啟用 CORS"
  type        = bool
  default     = false
}

variable "cors_allowed_headers" {
  description = "CORS 允許的 Headers"
  type        = list(string)
  default     = ["*"]
}

variable "cors_allowed_methods" {
  description = "CORS 允許的 Methods"
  type        = list(string)
  default     = ["GET", "PUT", "POST", "DELETE", "HEAD"]
}

variable "cors_allowed_origins" {
  description = "CORS 允許的 Origins"
  type        = list(string)
  default     = ["*"]
}

variable "cors_expose_headers" {
  description = "CORS 暴露的 Headers"
  type        = list(string)
  default     = ["ETag"]
}

variable "cors_max_age_seconds" {
  description = "CORS 預檢請求快取時間（秒）"
  type        = number
  default     = 3000
}
