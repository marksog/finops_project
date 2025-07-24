
module "network" {
  source = "../../modules/network"

  aws_region           = var.aws_region
  env_name             = var.env_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
}


# Iam roles
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  tags = {
    Environment = var.env_name
    Project     = "EKS"
  }
  
}

# eks cluster module
module "eks" {
  source  = "../../modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = "1.28"
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.private_subnet_ids

  # IAM integration
  cluster_iam_role_arn = module.iam.eks_cluster_role_arn
  node_iam_role_arn    = module.iam.eks_node_role_arn  # Pass the node role ARN

  # Node group configuration
  node_group_config = {
    "${var.cluster_name}-group" = {
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
    Project     = var.project_name
  }
}