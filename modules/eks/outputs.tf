output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "node_group_names" {
  description = "Names of the EKS managed node groups"
  value       = keys(var.node_group_config)
}