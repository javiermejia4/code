## VPC
resource "aws_vpc" "production-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMamba-VPC"
    },
  )
}

## Public Subnet
resource "aws_subnet" "public-subnet-1" {
  cidr_block = var.public_subnet_1_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMamba-PublicSubnet-1"
    },
  )
}

## Private Subnet
resource "aws_subnet" "private-subnet-1" {
  cidr_block = var.private_subnet_1_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMambaPrivateSubnet-1"
    },
  )

}

## Private Subnet 2
resource "aws_subnet" "private-subnet-2" {
  cidr_block = var.private_subnet_2_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMambaPrivateSubnet-2"
    },
  )
}

## Private Subnet
resource "aws_subnet" "private-subnet-3" {
  cidr_block = var.private_subnet_3_cidr
  vpc_id     = aws_vpc.production-vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMambaPrivateSubnet-3"
    },
  )
}

## Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMambaPublicRouteTable"
    },
  )
}

## Private Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMambaPrivateRouteTable"
    },
  )
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

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMambaProduction-IGW"
    },
  )
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

  tags = merge(
    local.common_tags,
    {
      Name = "BlackMamba-SG"
    },
  )

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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}