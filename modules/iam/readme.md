# IAM Module for EKS

This module creates the necessary IAM roles and policies for an EKS cluster and its worker nodes.

## Inputs

| Name          | Description                          | Type   | Default | Required |
|---------------|--------------------------------------|--------|---------|----------|
| `project_name`| The name of the project              | string | n/a     | yes      |
| `tags`        | Tags to apply to all resources       | map    | `{}`    | no       |

## Outputs

| Name                  | Description                                      |
|-----------------------|--------------------------------------------------|
| `eks_cluster_role_arn`| IAM role ARN for the EKS cluster control plane   |
| `eks_node_role_arn`   | IAM role ARN for the EKS worker nodes            |

## Example Usage

```terraform
module "iam" {
  source       = "../../modules/iam"
  project_name = "my-project"

  tags = {
    Environment = "dev"
    Project     = "EKS"
  }
}