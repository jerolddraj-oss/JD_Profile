variable "primary_region" {
  default = "us-east-1"
}

variable "secondary_region" {
  default = "us-west-2"
}

variable "eks_version" {
  default = "1.27"
}

variable "east_vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "west_vpc_cidr" {
  default = "10.20.0.0/16"
}
