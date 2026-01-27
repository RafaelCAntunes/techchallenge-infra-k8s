# Cluster Role
resource "aws_iam_role" "eks_cluster_role" {
  name = "techchallenge-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "eks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Node Role
resource "aws_iam_role" "eks_node_role" {
  name = "techchallenge-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "techchallenge-dynamodb-access-policy"
  description = "Permite que pods no EKS acessem tabelas DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTable"
        ]
        Resource = [
          "arn:aws:dynamodb:us-east-1:*:table/techchallenge-pagamentos",
          "arn:aws:dynamodb:us-east-1:*:table/techchallenge-pagamentos/index/*",
          "arn:aws:dynamodb:us-east-1:*:table/techchallenge-producao",
          "arn:aws:dynamodb:us-east-1:*:table/techchallenge-producao/index/*"
        ]
      }
    ]
  })

  tags = {
    Name = "techchallenge-dynamodb-access"
  }
}

resource "aws_iam_role_policy_attachment" "eks_dynamodb_policy" {
  policy_arn = aws_iam_policy.dynamodb_access.arn
  role       = aws_iam_role.eks_node_role.name
}