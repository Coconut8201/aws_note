# Bucket C - 啟用 CORS（適合前端靜態資源）

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name         = "bucket-c"
  versioning_enabled  = true
  block_public_access = true
  enable_cors         = true
  cors_allowed_origins = ["https://example.com", "http://localhost:3000"]
  cors_allowed_methods = ["GET", "PUT", "POST"]
  cors_allowed_headers = ["*"]
}
