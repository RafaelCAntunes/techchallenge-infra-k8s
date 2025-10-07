module "vpc" {
  source = "./vpc"
}

module "eks" {
  source       = "./eks"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  eks_role_arn  = module.iam.cluster_role_arn
  node_role_arn = module.iam.node_role_arn
  ssh_key_name = var.ssh_key_name
}

module "iam" {
  source= "./iam"
}


resource "aws_ecr_repository" "app" {
  name                 = "techchallenge_lanchonete"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "techchallenge_lanchonete"
  }
}
