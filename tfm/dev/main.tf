module "s3" {
  source = "../tfm/s3"
  env    = var.env

}

module "ecr" {
  source = "../tfm/ecr"
  env    = var.env

}

module "eks" {
  source        = "../tfm/eks"
  env           = var.env
  min_size      = 2
  max_size      = 2
  instance_type = "t3.micro"
  vpc_id = module.network.vpc_id
  subnet_ids = module.network.subnet_ids


}

module "network" {
  source                = "../tfm/network"
    env           = var.env
  region                = var.aws_region
  public_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  
}

module rds {
  source = "../tfm/rds"
  env = var.env
  subnet_ids = module.network.private_subnet_ids
  db_security_group_id = module.network.db_security_group_id
}

module "ssm" {
  source                = "../tfm/ssm"
  env                   = var.env
  tfm_bucket_name = module.s3.uploaded_assets_bucket_name

}

module "iam" {
  source                = "../tfm/iam"
  env                   = var.env
  s3_upload_bucket_name = module.s3.uploaded_assets_bucket_name
  account_id = var.account_id
  oidc_provider = module.eks.oidc_provider
  eks_cluster = module.eks.eks_cluster
  ecr_repo_arn = module.ecr.ecr_repo_arn
  db_secret_arn = module.rds.db_secret_arn

}