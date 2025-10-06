module "vpc" {
  source = "./vpc"

  region = var.aws_region
}

module "eks" {
  source = "./eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids
}

module "iam" {
  source= "./iam"
}
