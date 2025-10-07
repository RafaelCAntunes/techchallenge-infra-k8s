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

variable "ssh_key_name" {
  description = "Nome da chave SSH EC2 para os nodes do EKS"
  type        = string
}