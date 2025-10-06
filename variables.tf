variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "techchallenge-cluster"
}

variable "github_org" {
  description = "Organização ou usuário do GitHub"
  type        = string
}

variable "github_repo" {
  description = "Repositório da aplicação no GitHub"
  type        = string
}