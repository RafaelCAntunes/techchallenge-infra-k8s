variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "eks_role_arn" {
  description = "Role ARN usada pelo cluster"
  type        = string
}

variable "node_role_arn" {
  description = "Role ARN usada pelos nodes"
  type        = string
}