# Bucket B - 啟用生命週期規則（適合日誌存放）

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name            = "bucket-b"
  versioning_enabled     = false
  block_public_access    = true
  enable_lifecycle_rule  = true
  transition_to_ia_days  = 30
  transition_to_glacier_days = 90
  expiration_days        = 180
}
