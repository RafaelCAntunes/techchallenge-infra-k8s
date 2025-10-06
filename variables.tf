variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "techchallenge-cluster"
}