resource "aws_kms_key" "eks" {
  description             = "KMS key for EKS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_kms_alias" "eks" {
  name          = "alias/${var.environment}-eks-key"
  target_key_id = aws_kms_key.eks.key_id
}
