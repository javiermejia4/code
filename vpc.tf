locals {
  service = "Custom VPC"
  owner   = "Me"
  name    = "BlackMamba"

  common_tags = {
    owner   = local.owner
    name    = local.name
    service = local.service
  }
}

## VPC
resource "aws_vpc" "production-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = local.common_tags
}

## Public Subnet
resource "aws_subnet" "public-subnet-1" {
  cidr_block = var.public_subnet_1_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = local.common_tags
}

## Private Subnet
resource "aws_subnet" "private-subnet-1" {
  cidr_block = var.private_subnet_1_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = local.common_tags
}

## Private Subnet 2
resource "aws_subnet" "private-subnet-2" {
  cidr_block = var.private_subnet_2_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = local.common_tags
}

## Private Subnet
resource "aws_subnet" "private-subnet-3" {
  cidr_block = var.private_subnet_3_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = local.common_tags
}

## Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  tags = local.common_tags
}

## Private Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  tags = local.common_tags
}

## Route Table Associations
resource "aws_route_table_association" "public-subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "private-subnet-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}
## IGW
resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production-vpc.id

  tags = local.common_tags
}

resource "aws_route" "public-internet-gateway-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.production-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

## Security Groups
resource "aws_security_group" "allowed_traffic" {
  description = "Ingress Traffic"
  vpc_id      = aws_vpc.production-vpc.id

  tags = local.common_tags

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = var.allowed_ips
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}