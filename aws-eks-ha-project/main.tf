module "east_vpc" {
  source = "./modules/vpc"

  region      = "us-east-1"
  vpc_cidr    = var.east_vpc_cidr
  environment = "prod-east"
}

module "west_vpc" {
  source = "./modules/vpc"

  providers = {
    aws = aws.west
  }

  region      = "us-west-2"
  vpc_cidr    = var.west_vpc_cidr
  environment = "prod-west"
}

module "east_eks" {
  source = "./modules/eks"

  cluster_name       = "eks-east"
  kubernetes_version = var.eks_version
  vpc_id             = module.east_vpc.vpc_id
  subnet_ids         = module.east_vpc.private_subnets
  environment        = "prod-east"

  depends_on = [
    module.east_vpc
  ]
}

module "west_eks" {
  source = "./modules/eks"

  providers = {
    aws = aws.west
  }

  cluster_name       = "eks-west"
  kubernetes_version = var.eks_version
  vpc_id             = module.west_vpc.vpc_id
  subnet_ids         = module.west_vpc.private_subnets
  environment        = "prod-west"

  depends_on = [
    module.west_vpc
  ]
}

module "transit_gateway" {
  source = "./modules/transit-gateway"

  east_vpc_id = module.east_vpc.vpc_id
  west_vpc_id = module.west_vpc.vpc_id

  east_subnets = module.east_vpc.private_subnets
  west_subnets = module.west_vpc.private_subnets

  depends_on = [
    module.east_vpc,
    module.west_vpc
  ]
}
