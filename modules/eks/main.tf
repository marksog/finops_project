module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = var.cluster_name
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids

  # IAM intergration
  iam_role_arn = var.cluster_iam_role_arn
  enable_irsa = true

  # Node group configuration
  eks_managed_node_groups = var.node_group_config

  tags = var.tags
}