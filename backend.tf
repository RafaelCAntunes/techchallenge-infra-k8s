terraform {
  cloud {
    organization = "techchallenge-lanchonete" 

    workspaces {
      name = "techchallenge-infra-k8s"
    }
  }

  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}