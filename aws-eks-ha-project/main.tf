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
