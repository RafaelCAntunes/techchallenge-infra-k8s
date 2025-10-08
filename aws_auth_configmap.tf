resource "kubernetes_manifest" "aws_auth" {
  depends_on = [
    module.eks
  ]

  manifest = {
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = "aws-auth"
      namespace = "kube-system"
    }

    data = {
      # Permite que os nodes EKS se registrem no cluster
      mapRoles = yamlencode([
        {
          rolearn  = module.iam.node_role_arn
          username = "system:node:{{EC2PrivateDNSName}}"
          groups   = ["system:bootstrappers", "system:nodes"]
        }
      ])

      # Dá acesso de administrador ao usuário do Terraform Cloud
      mapUsers = yamlencode([
        {
          userarn  = "arn:aws:iam::165835313479:user/deploy-user"
          username = "deploy-user"
          groups   = ["system:masters"]
        }
      ])
    }
  }
}