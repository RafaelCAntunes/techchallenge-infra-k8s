output "eks_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "oidc_provider" {
  value = aws_iam_openid_connect_provider.github.arn
}