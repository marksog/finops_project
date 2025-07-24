variable "env_name" {
  description = "The name of the environment"
  type        = string
  default     = "development"
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "us-west-1" 
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  type        = string
  default     = "dev_key"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "dev-eks-cluster"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "EKS"
  
}