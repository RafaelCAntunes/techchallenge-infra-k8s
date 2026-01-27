output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
output "dynamodb_policy_arn" {
  value       = aws_iam_policy.dynamodb_access.arn
  description = "ARN da policy de acesso ao DynamoDB"
}
