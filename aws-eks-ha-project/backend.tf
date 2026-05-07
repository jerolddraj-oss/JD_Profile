terraform {
  backend "s3" {
    bucket       = "jd-terraform-state-bucket"
    key          = "aws-eks-ha/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
