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

resource "aws_ec2_transit_gateway_vpc_attachment" "west" {
  subnet_ids         = var.west_subnets
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.west_vpc_id

  tags = {
    Name = "west-vpc-attachment"
  }
}
