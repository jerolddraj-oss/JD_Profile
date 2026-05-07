module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  enable_irsa = true

  # Disable automatic KMS key creation for PoC stability.
  # Explicitly disable cluster encryption configuration to avoid
  # provider_key_arn dependency errors in EKS module v20.x.
  create_kms_key = false
  cluster_encryption_config = {}

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      min_size     = 2
      max_size     = 4

      instance_types = ["t3.large"]

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
