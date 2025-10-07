output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_ca_certificate" {
  value = module.eks.cluster_certificate_authority_data
}

output "subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "security_groups" {
  value = module.eks.node_group_sg_id
}