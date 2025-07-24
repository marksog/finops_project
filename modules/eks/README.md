# EKS Module

## Inputs
- `cluster_name`: Name of the EKS cluster.
- `kubernetes_version`: Kubernetes version for the cluster.
- `vpc_id`: VPC ID for the cluster.
- `subnet_ids`: List of subnet IDs.
- `node_group_config`: Configuration for managed node groups.
- `cluster_iam_role_arn`: IAM role ARN for the EKS control plane.

## Outputs
- `cluster_name`: Name of the EKS cluster.
- `cluster_endpoint`: Endpoint of the EKS cluster.
- `kubeconfig`: Kubeconfig for the cluster.
- `node_group_names`: Names of the node groups.

## Example Usage
```terraform
module "eks" {
  source  = "../../modules/eks"

  cluster_name       = "dev-cluster"
  kubernetes_version = "1.28"
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids

  node_group_config = {
    "dev-node-group" = {
      instance_types   = ["t3.medium"]
      desired_size     = 2
      min_size         = 1
      max_size         = 3
      disk_size        = 20
      labels           = {
        environment = "dev"
        nodeclass   = "worker"
      }
    }
  }

  tags = {
    Environment = "dev"
    Project     = "EKS"
  }
}