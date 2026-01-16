# Bucket A - 一般用途儲存

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name         = "bucket-a"
  versioning_enabled  = true
  block_public_access = true
}
