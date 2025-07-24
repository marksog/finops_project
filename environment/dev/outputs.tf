### VPC OUTPUTS
output "env_name" {
  description = "The name of the environment"
  value       = var.env_name
}

output "node_group_names" {
  description = "Names of the EKS managed node groups"
  value       = module.eks.node_group_names
}

