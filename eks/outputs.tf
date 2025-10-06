output "vpc_id" {
  value = var.vpc_id
}

# Subnets do cluster (públicas + privadas)
output "subnet_ids" {
  value = var.subnet_ids
}

# Security Group dos nodes EKS
output "node_group_sg_id" {
  value = aws_security_group.eks_nodes_sg.id
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_role_arn" {
  value = var.node_role_arn
}