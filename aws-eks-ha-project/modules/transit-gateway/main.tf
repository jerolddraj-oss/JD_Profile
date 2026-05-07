resource "aws_ec2_transit_gateway" "tgw" {
  description = "Hub Transit Gateway"

  tags = {
    Name = "hub-transit-gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "east" {
  subnet_ids         = var.east_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.east_vpc_id

  tags = {
    Name = "east-vpc-attachment"
  }
}

# Cross-region Transit Gateway attachment removed for PoC stability.
# AWS Transit Gateway is regional and requires inter-region peering
# instead of direct VPC attachment across regions.
