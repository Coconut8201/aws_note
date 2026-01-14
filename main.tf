# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = "10.0.0.0/18"
  public_subnet_cidr  = "10.0.0.0/20"
  private_subnet_cidr = "10.0.16.0/20"
  availability_zone-a = "${var.aws_region}a"
  availability_zone-c = "${var.aws_region}c"
}

# Security Group Module
module "security_group" {
  source = "./modules/security-group"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
}

# EC2 Module
module "public-ec2" {
  source = "./modules/ec2"

  project_name       = "${var.project_name}-1"
  environment        = var.environment
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.key_name
}

module "private-ec2" {
  source = "./modules/ec2"

  project_name       = "${var.project_name}-2"
  environment        = var.environment
  instance_type      = var.instance_type
  subnet_id          = module.vpc.private_subnet_id
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.key_name
}
