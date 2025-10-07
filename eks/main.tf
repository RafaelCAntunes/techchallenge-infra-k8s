data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.this.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.this.name
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types = ["t3.micro", "t2.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key               = var.ssh_key_name
    source_security_group_ids = [aws_security_group.eks_nodes_sg.id]
  }

  tags = {
    Name = "${var.cluster_name}-node"
  }
}

resource "aws_security_group" "eks_nodes_sg" {
  name        = "${var.cluster_name}-nodes-sg"
  description = "Security Group for EKS Node Group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-nodes-sg"
  }
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::165835313479:user/deploy-user"
        username = "deploy-user"
        groups   = ["system:masters"]
      }
    ])
  }

  lifecycle {
    ignore_changes = [data]
  }

  depends_on = [aws_eks_cluster.this]
}