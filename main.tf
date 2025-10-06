module "vpc" {
  source = "./vpc"
}

module "eks" {
  source       = "./eks"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids  # ← vamos criar esse output
  eks_role_arn  = module.iam.cluster_role_arn
  node_role_arn = module.iam.node_role_arn
}

module "iam" {
  source= "./iam"
}
