variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_config" {
  description = "Configuration for EKS managed node groups"
  type = map(object({
    instance_types   = list(string)
    desired_size     = number
    min_size         = number
    max_size         = number
    disk_size        = number
    labels           = map(string)
  }))
}

variable "cluster_iam_role_arn" {
  description = "IAM role ARN for the EKS cluster control plane"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "node_iam_role_arn" {
  description = "IAM role ARN for the EKS worker nodes"
  type        = string
}