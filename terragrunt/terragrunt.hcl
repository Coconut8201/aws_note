# 根目錄 terragrunt.hcl - 共用設定

# 產生 provider 設定（告訴 terraform 要接哪個雲服務）
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "ap-northeast-1"
}
EOF
}

# 遠端狀態設定（本地練習用，正式環境建議用 S3 backend（將設定檔案存到s3 中，把 s3 當成後端資料來源的意思））
remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# 共用輸入變數
inputs = {
  project_name = "demo"
  environment  = "dev"
}
